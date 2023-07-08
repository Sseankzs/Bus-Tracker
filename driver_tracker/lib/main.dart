import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? ref;

  // Variables for tracking
  int? currentTrackingRoute;
  int? currentTrackingBus = 1;
  int? currentTrackingSchedule = 1;
  List<dynamic>? scheduleData;
  int? currentStop = 0;
  Map? currentStopData = {
    "name": null,
    "lat": 0.0,
    "long": 0.0,
  };
  int? nextStop = 1;
  Map? nextStopData = {
    "name": null,
    "lat": 0.0,
    "long": 0.0,
  };
  int? duration = 0;
  int? distance = 0;
  http.Response? polyline;

  static const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  StreamSubscription<Position>? positionStream;

  void stopTrack() {
    setState(() {
      currentTrackingRoute = null;
      currentTrackingBus = 1;
      currentTrackingSchedule = 1;
      currentStop = 0;
      currentStopData = {
        "name": null,
        "lat": 0.0,
        "long": 0.0,
      };
      nextStop = 1;
      nextStopData = {
        "name": null,
        "lat": 0.0,
        "long": 0.0,
      };
      duration = 0;
      distance = 0;
      scheduleData = null;
      polyline = null;
      if (positionStream != null) positionStream?.cancel();
    });
    if (positionStream != null) positionStream?.cancel();
    ref?.child("bus$currentTrackingBus").update({
      'operation': false,
    });
    return;
  }

  void track(int route) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    while (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    // Reset previous route
    if (route == currentTrackingRoute) {
      stopTrack();
      return;
    }

    stopTrack();

    setState(() {
      currentTrackingRoute = route;
      ref = FirebaseDatabase.instance.ref('route$currentTrackingRoute');
    });

    // Start tracking
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) async {
      if (scheduleData == null) {
        var retrieve = await ref!.child('schedule$currentTrackingSchedule').get();
        setState(() {
          scheduleData = retrieve.value as List<dynamic>;
        });
        await ref?.child("bus$currentTrackingBus").update({
          'operation': true,
        });
      }
      //debugPrint(scheduleData.toString());
      // retrieve data from firebase
      if (currentStopData?["name"] == null) {
        currentStopData?["name"] = scheduleData![currentStop!.toInt()]['name'];
        currentStopData?["lat"] = scheduleData![currentStop!.toInt()]['lat'];
        currentStopData?["long"] = scheduleData![currentStop!.toInt()]['long'];
      }

      // next stop calculation
      if (nextStopData?["name"] == null) {
        nextStopData?["name"] = scheduleData![nextStop!.toInt()]['name'];
        nextStopData?["lat"] = scheduleData![nextStop!.toInt()]['lat'];
        nextStopData?["long"] = scheduleData![nextStop!.toInt()]['long'];
      }

      //debugPrint(currentStopData?.toString());
      //debugPrint(nextStopData?.toString());

      if (polyline == null) {
        //generate intermediates
        List<dynamic> intermediates = [];
        //loop through scheduleData
        for (int i = 1; i < scheduleData!.length - 1; i++) {
          intermediates.add('''{
            "location": {
              "latLng": {
                "latitude": ${scheduleData![i]['lat']},
                "longitude": ${scheduleData![i]['long']},
              }
            }
          }''');
        }

        //draw polyline
        polyline = await http.post(
          Uri.parse('https://routes.googleapis.com/directions/v2:computeRoutes'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': 'AIzaSyAPCuddVW7ch26c7zek493XKjRz4bnkKoc',
            'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters,routes.polyline,routes.legs.polyline',
          },
          body: '''{
            "origin":{
              "location":{
                "latLng":{
                  "latitude": ${scheduleData?[0]['lat']},
                  "longitude": ${scheduleData?[0]["long"]}
                }
              }
            },
            "destination":{
              "location":{
                "latLng":{
                  "latitude": ${scheduleData?[scheduleData!.length - 1]["lat"]},
                  "longitude": ${scheduleData?[scheduleData!.length - 1]["long"]}
                }
              }
            },
            "intermediates": $intermediates,
            "travelMode": "DRIVE"
          }''',
        );

        debugPrint(polyline?.statusCode.toString());
        debugPrint(polyline?.body.toString());
        var polylineBody = jsonDecode(polyline!.body);
        var polylinePoints = polylineBody['routes'][0]['polyline']['encodedPolyline'];

        await ref?.child("bus$currentTrackingBus").update({
          'polyline': polylinePoints,
        });
      }

      http.Response response = await http.post(
        Uri.parse('https://routes.googleapis.com/directions/v2:computeRoutes'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': 'AIzaSyAPCuddVW7ch26c7zek493XKjRz4bnkKoc',
          'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters',
        },
        body: '''{
          "origin":{
            "location":{
              "latLng":{
                "latitude": ${position?.latitude},
                "longitude": ${position?.longitude}
              }
            }
          },
          "destination":{
            "location":{
              "latLng":{
                "latitude": ${nextStopData?["lat"]},
                "longitude": ${nextStopData?["long"]}
              }
            }
          },
          "travelMode": "DRIVE"
        }''',
      );

      //debugPrint("Route API: ${response.statusCode}");
      //debugPrint("Route API: ${response.body}");

      var responseBody = jsonDecode(response.body);

      setState(() {
        distance = responseBody['routes'][0]['distanceMeters'];
        duration = int.parse(responseBody['routes'][0]['duration'].replaceAll(RegExp('[^0-9]'), ''));
      });

      // check if bus has reached next stop
      double p1 = position?.latitude as double;
      double p2 = position?.longitude as double;
      double p3 = nextStopData?["lat"] as double;
      double p4 = nextStopData?["long"] as double;
      double distanceInMeters = Geolocator.distanceBetween(p1, p2, p3, p4);
      debugPrint("Geolocator: $distanceInMeters");
      if (distance == null || duration == null) {
        distance = 0;
        duration = 0;
      }

      if (distanceInMeters < (50 + (position!.speed / 100 * 25)) ||
          distance! < (50 + (position.speed / 100 * 25)) ||
          duration! < (10 + (position.speed / 100 * 10))) {
        currentStop = nextStop;
        nextStop = nextStop! + 1;

        if (nextStop != scheduleData?.length) {
          debugPrint("Stop reached, moving to next stop");
          currentStopData = Map.from(nextStopData!);

          nextStopData?["name"] = scheduleData![nextStop!.toInt()]['name'];
          nextStopData?["lat"] = scheduleData![nextStop!.toInt()]['lat'];
          nextStopData?["long"] = scheduleData![nextStop!.toInt()]['long'];
        } else {
          debugPrint("Last stop reached");
          await ref?.child("bus$currentTrackingBus").update({
            'operation': false,
          });
          stopTrack();
        }
        return;
      }

      // Update to firebase
      await ref?.child("bus$currentTrackingBus").update({
        'lat': position.latitude,
        'long': position.longitude,
        'speed': position.speed,
        'heading': position.heading,
        'accuracy': position.accuracy,
        'altitude': position.altitude,
        'timeStamp': position.timestamp.toString(),
        'currentStop': currentStop,
        'nextStop': nextStop,
        'distance': distance,
        'duration': duration,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 162, 123, 92),
      ),
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/UTP-logo2.png', height: 100),
            const SizedBox(height: 10),
            Text(
              currentTrackingRoute == null ? "Track Status: Not Tracking" : "Track Status: Tracking on Route $currentTrackingRoute Bus $currentTrackingBus",
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Current Stop: ${currentStopData?["name"]}",
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Next Stop: ${nextStopData?["name"]}",
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Estimated Duration: $duration s",
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Estimated Distance: $distance m",
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: () => track(1),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Route 1", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                )),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: () => track(2),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Route 2", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                )),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: () => track(3),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Route 3", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                )),
          ],
        )),
      ),
    );
  }
}

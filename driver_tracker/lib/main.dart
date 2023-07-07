import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? ref;

  int? currentTrackingRoute;
  int? currentTrackingBus = 1;

  static const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  StreamSubscription<Position>? positionStream;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void track(int route) {
    if (route == currentTrackingRoute) {
      setState(() {
        currentTrackingRoute = null;
      });
      if (positionStream != null) positionStream?.cancel();
      return;
    }
    currentTrackingRoute = null;
    if (positionStream != null) positionStream?.cancel();

    setState(() {
      currentTrackingRoute = route;
    });

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) async {
      ref = FirebaseDatabase.instance.ref("route$currentTrackingRoute/bus$currentTrackingBus");
      await ref?.update({
        'lat': position?.latitude,
        'long': position?.longitude,
        'speed': position?.speed,
        'heading': position?.heading,
        'accuracy': position?.accuracy,
        'altitude': position?.altitude,
      });
      debugPrint(position == null
          ? 'Unknown data on $currentTrackingRoute'
          : '$currentTrackingRoute : ${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
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

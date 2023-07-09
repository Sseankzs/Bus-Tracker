import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_map_polyline_point/flutter_polyline_point.dart';
import 'package:flutter_google_map_polyline_point/point_lat_lng.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapsState();
}

class _MapsState extends State<MapPage> {
  late GoogleMapController mapController;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? ref;
  StreamSubscription<DatabaseEvent>? positionStream;

  int? currentTrackingRoute;
  int? currentTrackingBus = 1;
  int? currentTrackingSchedule = 1;

  double? latitude = 0.0;
  double? longitude = 0.0;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    track(1);
  }

  BitmapDescriptor busIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "images/bus-64.png").then(
      (icon) {
        busIcon = icon;
      },
    );
  }

  final Set<Polyline> _polyline = {};
  final Set<Marker> _markers = {};

  void track(int route) async {
    currentTrackingRoute = route;
    currentTrackingBus = 1;
    currentTrackingSchedule = 1;
    if (positionStream != null) positionStream?.cancel();
    _polyline.clear();
    _markers.clear();

    final ref = FirebaseDatabase.instance.ref('route$currentTrackingRoute');

    // get polyline data
    final polyline = await ref.child('bus$currentTrackingBus/polyline').get();

    // if polyline data exists
    // decode polyline data into List<LatLng>
    // add polyline to map
    if (polyline.exists && _polyline.isEmpty) {
      debugPrint(polyline.value.toString());
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> latlng = polylinePoints.decodePolyline(polyline.value.toString());
      // convert List<PointLatLng> into List<LatLng>
      List<LatLng> points = [];
      for (var i = 0; i < latlng.length; i++) {
        points.add(LatLng(latlng[i].latitude, latlng[i].longitude));
      }

      if (mounted) {
        setState(() {
          _polyline.clear();
          _polyline.add(Polyline(
            polylineId: const PolylineId('route'),
            visible: true,
            //latlng is List<LatLng>
            points: points,
            width: 5,
            color: Colors.blue,
          ));
        });
      }
    } else {
      debugPrint('No polyline data available.');
    }

    // add first marker
    // get schedule data
    var schedule = await ref.child('schedule$currentTrackingSchedule').get();
    if (schedule.exists && _markers.isEmpty) {
      if (schedule.value == null) return;

      List<dynamic> scheduleData = schedule.value as List<dynamic>;

      // iterate through schedule data
      // add marker to map
      for (var i = 0; i < scheduleData.length; i++) {
        if (scheduleData[i] != null) {
          _markers.add(Marker(
            markerId: MarkerId("${scheduleData[i]['name']}"),
            infoWindow: InfoWindow(title: "${scheduleData[i]['name']}"),
            position: LatLng(scheduleData[i]['lat'], scheduleData[i]['long']),
          ));
        }
      }

      debugPrint(_markers.toString());

      _markers.add(Marker(
        markerId: const MarkerId("bus"),
        position: LatLng(latitude!, longitude!),
        icon: busIcon,
      ));
    } else {
      debugPrint('No schedule data available.');
    }

    positionStream = ref.onValue.listen((DatabaseEvent event) async {
      final lat = await ref.child('bus$currentTrackingBus/lat').get();
      if (lat.exists) {
        debugPrint(lat.value.toString());
      } else {
        debugPrint('No lat data available.');
      }
      final long = await ref.child('bus$currentTrackingBus/long').get();
      if (long.exists) {
        debugPrint(long.value.toString());
      } else {
        debugPrint('No long data available.');
      }
      if (lat.value != null && long.value != null) {
        latitude = double.parse(lat.value.toString());
        longitude = double.parse(long.value.toString());
        if (_markers.isNotEmpty) {
          _markers.remove(_markers.last);
          if (mounted) {
            setState(() {
              _markers.add(Marker(
                markerId: const MarkerId("bus"),
                position: LatLng(latitude!, longitude!),
                icon: busIcon,
              ));
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    if (positionStream != null) positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrackingRoute != null) {
      CameraPosition currentLocation = CameraPosition(target: LatLng(latitude!, longitude!), zoom: 16);
      mapController.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 5.0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('BUS ', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22)),
              Text('TRACK', style: TextStyle(color: Color.fromARGB(255, 162, 123, 92), fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22))
            ],
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          polylines: _polyline,
          //markers: <Marker>{_createMarker()},
          initialCameraPosition: const CameraPosition(
            target: LatLng(4.3847634, 100.9708649),
            zoom: 16.0,
          ),
          myLocationEnabled: true,
          zoomControlsEnabled: false,
        ),
        // Floating Action Button
        floatingActionButton: SpeedDial(
          label: const Text("Select Route", style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 12)),
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          renderOverlay: false,
          animationDuration: const Duration(milliseconds: 300),
          spacing: 20,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.directions_bus),
              label: 'External Route',
              onTap: () {
                track(1);
              }, // Set Action
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_bus),
              label: 'Internal Route',
              onTap: () {
                track(2);
              }, // Set Action
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_bus),
              label: 'Station 18 Route',
              onTap: () {
                track(3);
              }, // Set Action
            ),
          ],
        ));
  }
}

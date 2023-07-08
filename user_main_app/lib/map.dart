import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapsState();
}

class _MapsState extends State<MapPage> {
  late GoogleMapController mapController;

  static const LatLng center = LatLng(4.3847634, 100.9708649);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? ref;
  StreamSubscription<DatabaseEvent>? positionStream;

  int? currentTrackingRoute;
  int? currentTrackingBus = 1;

  double? latitude = 0.0;
  double? longitude = 0.0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    track(1);
  }

  void track(int route) {
    if (route == currentTrackingRoute) {
      setState(() {
        currentTrackingRoute = null;
        positionStream?.cancel();
      });
      return;
    }
    setState(() {
      currentTrackingRoute = route;
    });

    final ref = FirebaseDatabase.instance.ref('route$currentTrackingRoute/bus$currentTrackingBus');

    positionStream = ref.onValue.listen((DatabaseEvent event) async {
      final lat = await ref.child('lat').get();
      if (lat.exists) {
        debugPrint(lat.value.toString());
      } else {
        debugPrint('No data available.');
      }
      final long = await ref.child('long').get();
      if (long.exists) {
        debugPrint(long.value.toString());
      } else {
        debugPrint('No data available.');
      }
      setState(() {
        latitude = double.parse(lat.value.toString());
        longitude = double.parse(long.value.toString());
      });
    });
  }

  BitmapDescriptor? _markerIcon;

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: LatLng(latitude!, longitude!),
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: LatLng(latitude!, longitude!),
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size.square(8));
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'images/bus-32.png').then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "images/bus-32.png").then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrackingRoute != null) {
      CameraPosition currentLocation = CameraPosition(target: LatLng(latitude!, longitude!), zoom: 16);
      mapController.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
    }
    return GoogleMap(
        onMapCreated: _onMapCreated,
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(latitude!, longitude!),
            icon: markerIcon,
          ),
        },
        //markers: <Marker>{_createMarker()},
        initialCameraPosition: const CameraPosition(
          target: center,
          zoom: 16.0,
        ),
        myLocationEnabled: true);
  }
}

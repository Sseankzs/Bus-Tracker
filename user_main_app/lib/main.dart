import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'firebase_options.dart';
import 'package:user/bus_track.dart';
import 'package:user/eta.dart';
import 'package:user/schedule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return;
  }
  LocationPermission permission = await Geolocator.checkPermission();
  while (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _LogInState();
}

class _LogInState extends State<MainPage> {
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [ETA(), BusTrack(), Schedule()][currentpage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(162, 123, 92, 1),
        animationDuration: const Duration(milliseconds: 500),
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.roundabout_left,
                color: Colors.black,
              ),
              label: 'ETA'),
          NavigationDestination(
              icon: Icon(
                Icons.map,
                color: Colors.black,
              ),
              label: 'Maps'),
          NavigationDestination(
              icon: Icon(
                Icons.table_chart,
                color: Colors.black,
              ),
              label: 'Schedule'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentpage = index;
          });
        },
        selectedIndex: currentpage,
      ),
    );
  }
}

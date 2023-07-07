import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:user/eta.dart';
import 'package:user/map.dart';
import 'package:user/schedule.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

void main() {
  runApp(const MyApp());
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
      body: const [ETA(), MapPage(), Schedule()][currentpage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.roundabout_left), label: 'ETA'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Maps'),
          NavigationDestination(
              icon: Icon(Icons.table_chart), label: 'Schedule'),
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

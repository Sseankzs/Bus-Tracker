import 'package:flutter/material.dart';
import 'package:user/map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BusTrack extends StatelessWidget {
  const BusTrack({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text('BUS', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22)),
            Text(' ', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22)),
            Text('TRACK', style: TextStyle(color: Color.fromARGB(255, 162, 123, 92), fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22))
          ],
        ),
      ),
      body: const MapPage(),
      // Floating Action Button
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.05,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.directions_bus),
            label: 'Internal Route',
            onTap: (){}, // Set Action
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_bus),
            label: 'External Route',
            onTap: (){}, // Set Action
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_bus),
            label: 'Station 18 Route',
            onTap: (){}, // Set Action
          ),
        ],
      )
    );
  }
}

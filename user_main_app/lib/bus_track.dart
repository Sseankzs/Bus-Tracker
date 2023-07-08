import 'package:flutter/material.dart';
import 'package:user/map.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Set action
        },
        child: const Icon(Icons.list),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}

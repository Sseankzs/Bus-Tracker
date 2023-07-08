import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('    ',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),
            Text('Bus',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),
            Text(' ',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),
            Text('Schedule',
                style: TextStyle(
                    color: Color.fromARGB(255, 162, 123, 92),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32))
          ],
        ),
        const Text('This page displays latest bus schedule.',
            style: TextStyle(
                color: Color.fromARGB(60, 0, 0, 0),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 10)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Shuttle Bus to Station 18',
                style: TextStyle(
                    color: Color.fromARGB(60, 0, 0, 0),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 12)),
            Image.asset('images/UTP Bus Schedule 21.12.2020 v2.png')
            
          ],
        )
      ],
    ));
  }
}

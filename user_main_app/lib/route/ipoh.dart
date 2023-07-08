import 'package:flutter/material.dart';

class Ipoh extends StatefulWidget {
  const Ipoh({super.key});

  @override
  State<Ipoh> createState() => _IpohState();
}

class _IpohState extends State<Ipoh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ipoh Route'),
      ),
      body: Column(
        children: [
          Container(),
          const Padding(
            padding: EdgeInsets.all(50.0),
          ),
          const Text.rich(
            TextSpan(
              text: 'Estimated Arrival Time',
              style: TextStyle(
                  color: Color(0xFF2C3639),
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 285,
            height: 32,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

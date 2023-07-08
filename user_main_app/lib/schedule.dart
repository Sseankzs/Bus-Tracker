import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: const Color.fromRGBO(220, 215, 201, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // Bus Schedule
                children: [
                  Text('       '),
                  Text('Bus',
                      style: TextStyle(
                          color: Color.fromRGBO(63, 78, 79, 1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 36)),
                  Text(' ',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 36)),
                  Text('Schedule',
                      style: TextStyle(
                          color: Color.fromARGB(255, 162, 123, 92),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 36))
                ],
              ),
              const Row(
                // This page displays ...
                children: [
                  Text('        '),
                  Text('This page displays latest bus schedule.',
                      style: TextStyle(
                          color: Color.fromARGB(60, 0, 0, 0),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 10)),
                ],
              ),
              const SizedBox(height: 20),

              // First Image Container________________________________
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('        '),
                      Text('Shuttle Bus to Station 18',
                          style: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 0),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            focusColor: Colors.white,
                            onTap: () {
                              //Set Action
                            },
                            child: Card(
                              child: Container(
                                  width: 500,
                                  height: 130,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(0, 4)),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: ZoomOverlay(
                                    modalBarrierColor:
                                        Colors.black12,
                                    minScale: 0.5,
                                    maxScale: 3.0,
                                    animationCurve: Curves
                                        .fastOutSlowIn, // Defaults to fastOutSlowIn which mimics IOS instagram behavior
                                    animationDuration: const Duration(
                                        milliseconds:
                                            50), // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn
                                    twoTouchOnly: true, // Defaults to false
                                    child: Image.asset(
                                        'images/UTP_Bus Schedule_Shuttle Bus to Stn 18.png'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Second Image Container________________________________
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('        '),
                      Text('External Bus',
                          style: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 0),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            focusColor: Colors.white,
                            onTap: () {
                              //Set Action
                            },
                            child: Card(
                              child: Container(
                                  width: 500,
                                  height: 230,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(0, 4)),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: ZoomOverlay(
                                    modalBarrierColor:
                                        Colors.black12, 
                                    minScale: 0.5, 
                                    maxScale: 3.0, 
                                    animationCurve: Curves
                                        .fastOutSlowIn, // Defaults to fastOutSlowIn which mimics IOS instagram behavior
                                    animationDuration: const Duration(
                                        milliseconds:
                                            50), // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn
                                    twoTouchOnly: true, // Defaults to false
                                    child: Image.asset(
                                        'images/UTP_Bus Schedule_External.png'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Third Image Container________________________________
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('        '),
                      Text('Internal Bus',
                          style: TextStyle(
                              color: Color.fromARGB(150, 0, 0, 0),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            focusColor: Colors.white,
                            onTap: () {
                              //Set Action
                            },
                            child: Card(
                              child: Container(
                                  width: 500,
                                  height: 190,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(0, 4)),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: ZoomOverlay(
                                    modalBarrierColor:
                                        Colors.black12,
                                    minScale: 0.5,
                                    maxScale: 3.0,
                                    animationCurve: Curves
                                        .fastOutSlowIn, // Defaults to fastOutSlowIn which mimics IOS instagram behavior
                                    animationDuration: const Duration(
                                        milliseconds:
                                            50), // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn
                                    twoTouchOnly: true, // Defaults to false
                                    child: Image.asset(
                                        'images/UTP_Bus Schedule_Internal.png'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

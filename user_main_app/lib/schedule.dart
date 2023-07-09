import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    // TO DO: Retrieve from firebase
    List<dynamic> busSchedule = [
      {"title": "Internal Shuttle Bus", "image": "images/UTP_Bus Schedule_Internal.png", "route": 1},
      {"title": "External Shuttle Bus (Seri Iskandar)", "image": "images/UTP_Bus Schedule_External.png", "route": 2},
      {"title": "External Shuttle Bus (Stn 18)", "image": "images/UTP_Bus Schedule_Shuttle Bus to Stn 18.png", "route": 3}
    ];

    List<Widget> widgets = [];

    //loop through schedule
    for (var route in busSchedule) {
      widgets.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 1),
        child: Text(
          route["title"],
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 12, fontFamily: 'Poppins'),
        ),
      ));
      widgets.add(
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: FullScreenWidget(
                disposeLevel: DisposeLevel.Medium,
                child: Center(
                  child: ZoomOverlay(
                    modalBarrierColor: Colors.black12,
                    minScale: 0.5,
                    maxScale: 3.0,
                    animationCurve: Curves.fastOutSlowIn, // Defaults to fastOutSlowIn which mimics IOS instagram behavior
                    animationDuration: const Duration(
                        milliseconds:
                            300), // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn// Defaults to false
                    child: Hero(
                      tag: route["title"],
                      child: Image.asset(route["image"]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
          color: const Color.fromRGBO(220, 215, 201, 1),
          child: Column(
            children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Bus Schedule
                    children: [
                      Text('Bus ', style: TextStyle(color: Color.fromRGBO(63, 78, 79, 1), fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 36)),
                      Text('Schedule',
                          style: TextStyle(color: Color.fromARGB(255, 162, 123, 92), fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 36))
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                    child: const Text(
                      'This page displays latest bus schedule.',
                    ),
                  ),
                ] +
                widgets,
          )),
    );
  }
}

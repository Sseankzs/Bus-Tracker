import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    // TO DO: Retrieve from firebase
    List<dynamic> busSchedule = [
      {"title": "External Shuttle Bus (Seri Iskandar)", "image": "images/UTP_Bus Schedule_External.png", "route": 1},
      {"title": "Internal Shuttle Bus", "image": "images/UTP_Bus Schedule_Internal.png", "route": 2},
      {"title": "External Shuttle Bus (Stn 18)", "image": "images/UTP_Bus Schedule_Shuttle Bus to Stn 18.png", "route": 3}
    ];

    List<Widget> widgets = [];

    //loop through schedule
    for (var route in busSchedule) {
      widgets.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text(
          route["title"],
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 15, fontFamily: 'Poppins'),
        ),
      ));
      widgets.add(
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: WidgetZoom(
              heroAnimationTag: route["title"],
              zoomWidget: Image.asset(route["image"]),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
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
                ] +
                widgets,
          )),
    );
  }
}

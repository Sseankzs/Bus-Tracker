import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ETA extends StatefulWidget {
  const ETA({super.key});

  @override
  State<ETA> createState() => _ETAState();
}

class _ETAState extends State<ETA> {
  int nextStopNum = 0;
  String nextStop = '-';
  DatabaseReference? _database;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  // TO DO: Retrieve from firebase
  List<dynamic> busSchedule = [
    {"title": "Internal Shuttle Bus", "image": "images/UTP_Bus Schedule_Internal.png", "route": 1},
    {"title": "External Shuttle Bus (Seri Iskandar)", "image": "images/UTP_Bus Schedule_External.png", "route": 2},
    {"title": "External Shuttle Bus (Stn 18)", "image": "images/UTP_Bus Schedule_Shuttle Bus to Stn 18.png", "route": 3}
  ];

  List data = [];

  void _activateListeners() {
    _database = FirebaseDatabase.instance.ref();

    for (var route in busSchedule) {
      data.add({'listen': null, 'operation': false, 'nextStopName': '-', 'duration': '-'});
      int id = route['route'];
      data[id - 1]['listen'] = _database?.child('route$id').onValue.listen(
        (event) async {
          final operation = await _database?.child('route$id/bus1/operation').get();
          debugPrint("Route $id: ${operation!.value}");
          if (bool.parse(operation.value.toString())) {
            final nextStop = await _database?.child('route$id/bus1/nextStop').get();
            final nextStopName = await _database?.child('route$id/schedule1/${nextStop!.value}/name').get();

            final duration = await _database?.child('route$id/bus1/duration').get();

            data[id - 1]['nextStopName'] = nextStopName!.value.toString();
            data[id - 1]['duration'] = int.parse(duration!.value.toString());
          } else {
            data[id - 1]['nextStopName'] = '-';
            data[id - 1]['duration'] = '-';
          }

          setState(() {
            data[id - 1]['operation'] = bool.parse(operation.value.toString());
          });

          debugPrint("Route $id: ${data[id - 1]}");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var route in busSchedule) {
      int id = route['route'];

      String time;
      if (data[id - 1]['duration'] != '-') {
        final now = DateTime.now();
        final later = now.add(Duration(seconds: data[id - 1]['duration']));
        time = "${later.hour - 12}:${later.minute.toString().padLeft(2, '0')}${later.hour > 12 ? 'PM' : 'AM'}";
      } else {
        time = '00:00PM';
      }

      widgets.add(Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 1),
        child: Text(
          route["title"],
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 12, fontFamily: 'Poppins'),
        ),
      ));

      widgets.add(Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
        child: Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(15, 1, 15, 1),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 4)),
              ],
              color: Colors.white,
            ),
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 15,
                      color: data[id - 1]['operation'] ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: constraints.maxWidth - 100,
                      child: Text(
                        'Next Stop:  ${data[id - 1]['nextStopName']}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          time,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })),
      ));
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              color: const Color.fromRGBO(220, 215, 201, 1),
              child: Column(
                children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Wel',
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 78, 79, 1),
                                  fontSize: 36,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'come',
                                style: TextStyle(
                                  color: Color.fromRGBO(162, 123, 92, 1),
                                  fontSize: 36,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                        child: const Text(
                          'This page displays updated status of each route',
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 1),
                        child: const Text(
                          'Estimated Arrival Time Status',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ] +
                    widgets,
              ),
            ),
          ),
        );
      },
    );
  }
}

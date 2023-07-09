import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user/route_details.dart';
import 'package:intl/intl.dart';

class ETA extends StatefulWidget {
  const ETA({super.key});

  @override
  State<ETA> createState() => _ETAState();
}

class _ETAState extends State<ETA> {
  final _database = FirebaseDatabase.instance.ref();
  late Details route3;
  late Details route1;
  late Details route2;

  dynamic eta1 = DateTime.now();
  dynamic eta2 = DateTime.now();
  dynamic eta3 = DateTime.now();

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    dynamic now = DateTime.now();

    _database.child('route1/bus1').onValue.listen(
      (event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        route1 = Details.fromBusDB(data);
        setState(
          () {
            if (route1.operating == true) {
              route1.dotStatus = const Color.fromRGBO(0, 255, 0, 1);
              eta1 = now.add(
                Duration(seconds: route1.seconds),
              );
              if (route1.nextStopNum == 0) {
                route1.nextStop = 'PMMD';
              } else if (route1.nextStopNum == 1) {
                route1.nextStop = 'Lotus Seri Ikandar';
              } else if (route1.nextStopNum == 2) {
                route1.nextStop = 'Seri Iskandar Bus Stn';
              } else if (route1.nextStopNum == 3) {
                route1.nextStop = 'PMMD';
              }
            } else {
              route1.dotStatus = const Color.fromRGBO(255, 0, 0, 1);
              route1.nextStop = '-';
            }
          },
        );
      },
    );
    _database.child('route2/bus1').onValue.listen(
      (event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        route2 = Details.fromBusDB(data);
        setState(
          () {
            if (route2.operating == true) {
              route2.dotStatus = const Color.fromRGBO(0, 255, 0, 1);
              eta2 = now.add(
                Duration(seconds: route2.seconds),
              );
              if (route2.nextStopNum == 0) {
                route2.nextStop = 'PMMD';
              } else if (route2.nextStopNum == 1) {
                route2.nextStop = 'An-Nur Mosque';
              } else if (route2.nextStopNum == 2) {
                route2.nextStop = 'Chancellor Complex';
              } else if (route2.nextStopNum == 3) {
                route2.nextStop = 'R&D';
              }
            } else {
              route2.dotStatus = const Color.fromRGBO(255, 0, 0, 1);
              route2.nextStop = '-';
            }
          },
        );
      },
    );
    _database.child('route3/bus1').onValue.listen(
      (event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        route3 = Details.fromBusDB(data);
        setState(
          () {
            if (route3.operating == true) {
              route3.dotStatus = const Color.fromRGBO(0, 255, 0, 1);
              eta3 = now.add(
                Duration(seconds: route3.seconds),
              );
              if (route3.nextStopNum == 0) {
                route3.nextStop = 'PMMD';
              } else if (route3.nextStopNum == 1) {
                route3.nextStop = 'Aeon Station 18';
              } else if (route3.nextStopNum == 2) {
                route3.nextStop = 'PMMD';
              }
            } else {
              route3.dotStatus = const Color.fromRGBO(255, 0, 0, 1);
              route3.nextStop = '-';
            }
          },
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
                children: [
                  Column(
                    children: [
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

                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 1),
                        child: const Text(
                          'Internal Shuttle Bus',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                        ),
                      ),

                      //First Container
                      Container(
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
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(0, 4)),
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  size: 15,
                                  color: route2.dotStatus,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Next Stop:  ${route2.nextStop}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'ETA : ${DateFormat.jm().format(eta2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 1),
                        child: const Text(
                          'External Shuttle Bus (Seri Iskandar)',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                        ),
                      ),
                      //Second Container
                      Container(
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
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(0, 4)),
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  size: 15,
                                  color: route1.dotStatus,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Next Stop: ${route1.nextStop}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'ETA: ${DateFormat.jm().format(eta1)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 1),
                        child: const Text(
                          'External Shuttle Bus (Stn 18)',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                        ),
                      ),
                      //Third Container
                      Container(
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
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 4)),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                size: 15,
                                color: route3.dotStatus,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Next Stop: ${route3.nextStop}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'ETA ${DateFormat.jm().format(eta2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

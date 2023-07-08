import 'package:flutter/material.dart';
import 'package:user/internal_route.dart';
import 'package:user/ipoh.dart';
import 'package:user/si_route.dart';

class ETA extends StatelessWidget {
  const ETA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              padding: const EdgeInsets.fromLTRB(17, 38, 19, 2),
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(17, 38, 19, 2),
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
            ),
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(34, 2, 1, 5),
              child: const Text(
                'This page displays updated status of each route',
              ),
            ),

            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(34, 20, 1, 1),
              child: const Text(
                'ETA Status',
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
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(34, 20, 1, 1),
              child: const Text(
                'Internal Shuttle Bus',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),

            //First Container
            Positioned(
              child: Container(
                color: const Color.fromRGBO(220, 215, 201, 1),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      focusColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const Internal();
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                            width: 350,
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
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  size: 12,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Next Stop: ',
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(width: 140),
                                Text(
                                  'ETA - 00:00PM',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(34, 20, 1, 1),
              child: const Text(
                'External Shuttle Bus (Seri Iskandar)',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            //Second Container
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SeriIskandar();
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.all(20),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(34, 20, 1, 1),
              child: const Text(
                'External Shuttle Bus (Stn 18)',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            //Third Container
            Container(
              color: const Color.fromRGBO(220, 215, 201, 1),
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Ipoh();
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.all(20),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 204,
              color: const Color.fromRGBO(220, 215, 201, 1),
              child: const Text(
                'ETA - Estimated Arrival Time',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 13),
              ),
            )
          ],
        ),
      ],
    );
  }
}

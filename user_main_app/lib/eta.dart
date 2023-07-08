import 'package:flutter/material.dart';
import 'package:user/internal_route.dart';
import 'package:user/ipoh.dart';
import 'package:user/si_route.dart';

class ETA extends StatelessWidget {
  const ETA({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              //alignment: const Alignment(0.01, 0.2),
              padding: const EdgeInsets.fromLTRB(17, 38, 19, 2),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Wel',
                      style: TextStyle(
                        color: Color.fromRGBO(63, 78, 79, 1),
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'come',
                      style: TextStyle(
                        color: Color.fromRGBO(162, 123, 92, 1),
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Text(
              'This page displays updated status of each route',
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(1, 20, 1, 1),
              child: const Text(
                'ETA Status',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const Text(
              'Internal Shuttle Bus',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 10, fontFamily: 'Poppins'),
            ),
            //First Container
            Positioned(
              child: Container(
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
                          width: 315,
                          height: 50,
                          padding: const EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                  color: Colors.black,
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
            ),
            const Text(
              'External Shuttle Bus (Seri Iskandar)',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 10, fontFamily: 'Poppins'),
            ),
            //Second Container
            Container(
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
                        width: 315,
                        height: 50,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                                color: Colors.black,
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
            const Text(
              'External Shuttle Bus (Stn 18)',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 10, fontFamily: 'Poppins'),
            ),
            //Third Container
            Container(
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
                        width: 315,
                        height: 50,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                                color: Colors.black,
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
          ],
        ),
      ],
    );
  }
}

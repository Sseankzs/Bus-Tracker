import 'package:flutter/material.dart';

class Details {
  late int nextStopNum;
  String nextStop = '-';
  bool operating;
  Color dotStatus = const Color.fromRGBO(255, 0, 0, 1);
  int seconds;

  Details(
      {required this.nextStopNum,
      required this.operating,
      required this.seconds});

  factory Details.fromBusDB(Map<String, dynamic> data) {
    return Details(
        nextStopNum: data['nextStop'],
        operating: data['operation'],
        seconds: data['duration']);
  }
}

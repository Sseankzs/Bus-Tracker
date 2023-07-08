import 'package:flutter/material.dart';

class Details {
  late int nextStopNum;
  String nextStop = '-';
  bool operating;
  Color dotStatus = const Color.fromRGBO(255, 0, 0, 1);

  Details({required this.nextStopNum, required this.operating});

  factory Details.fromBusDB(Map<String, dynamic> data) {
    return Details(
      nextStopNum: data['nextStop'],
      operating: data['operation'],
    );
  }
}

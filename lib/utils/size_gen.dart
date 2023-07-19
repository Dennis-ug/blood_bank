import 'package:flutter/material.dart';

class Sizing {
  final double _ph = 1024;
  final double _pw = 1440;
  final BuildContext context;
  Sizing(this.context);
  double hyt(double hyt) {
    final result = hyt / _ph * 100;
    return MediaQuery.of(context).size.height * result / 100;
  }

  double wyt(double wyt) {
    final result = wyt / _pw * 100;
    final width = MediaQuery.of(context).size.width * result / 100;
    // debugPrint(" width:$width $result%");

    return width;
  }
}

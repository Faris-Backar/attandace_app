import 'package:flutter/material.dart';

class Config {
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static EdgeInsets defaultPadding() {
    return const EdgeInsets.all(16.0);
  }
}

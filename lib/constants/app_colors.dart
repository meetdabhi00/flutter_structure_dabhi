import 'package:flutter/material.dart';

class AppColor {
  static const Color _black = Colors.black;
  static const Color _white = Colors.white;
  static const Color _blueAccent = Colors.blueAccent;
  static const Color _blue = Colors.blue;
  static const Color _grey = Colors.grey;
  static const Color _red = Colors.red;

  static late Color background;
  static late Color appbarColor;
  static late Color appbarTextColor;
  static late Color black;
  static late Color white;
  static late Color grey;
  static late Color textColor;
  static late Color highlightTextColor;
  static late Color buttonColor;
  static late Color red;
  static late Color icon;
  static late Color buttonTextColor;

  static void loadColor(bool isLightMode) {
    if (isLightMode) {
      loadLight();
    } else {
      loadDark();
    }
  }

  static void loadLight() {
    background = _white;
    appbarTextColor = _white;
    appbarColor = _black;
    black = _black;
    white = _white;
    textColor = _black;
    highlightTextColor = _blueAccent;
    buttonTextColor = _white;
    buttonColor = _blue;
    grey = _grey;
    red = _red;
    icon = _black;
  }

  static void loadDark() {
    background = _black;
    appbarTextColor = _black;
    appbarColor = _white;
    black = _white;
    textColor = _white;
    highlightTextColor = _blueAccent;
    buttonTextColor = _white;
    buttonColor = _blue;
    grey = _grey;
    red = _red;
    icon = _white;
  }
}

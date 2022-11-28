import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorsTheme {
  static Color textColor = Color(0xff0ca898);
  static Color greenBackground = Color(0xff157493);
  static Color blueBackground = Color(0xff0ca898);
  static double generalPadding = 20;
  static double inputMarginButton = 20;
  static Color navbarColor = Color(0xfffefefe);
  static Color generalColorText = Colors.black54;

  static BoxDecoration backGrondGradient = BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      ColorsTheme.greenBackground,
      ColorsTheme.blueBackground,
    ],
  ));
}

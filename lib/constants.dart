import 'package:flutter/material.dart';

height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

var appPinkColor = HexColor("ff7878");

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

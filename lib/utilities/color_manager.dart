import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#56A03F");
  static Color darkGrey = HexColor.fromHex("#56A03F");
  static Color grey = HexColor.fromHex("#A6A7B6");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color lightprimary = HexColor.fromHex("#A2E0C6");
  static Color ButtonPrimary = HexColor.fromHex("#2BB3B3");
  static Color primaryOpacity70 = HexColor.fromHex("#AF0C2844");
  static Color primaryPink = HexColor.fromHex("#A3B6325F");

  // new colors
  static Color darkPrimary = HexColor.fromHex("#FFD300");
  static Color grey1 = HexColor.fromHex("#F5F4FA");
  static Color green = HexColor.fromHex("#62C83F");
  static Color red = HexColor.fromHex("#D11A2A");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black= HexColor.fromHex("#000000"); // red color
  static Color black12= HexColor.fromHex("f2f2f2"); // red color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

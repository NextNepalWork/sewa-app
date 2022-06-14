import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryBlue = Colors.blue;
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color orange = HexColor.fromHex("#FF7420");
  static Color primaryOpacity70 = HexColor.fromHex("#4969FF").withOpacity(.7);

  //new colors
  static Color darkPrimary = HexColor.fromHex("#00008B");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color grey3 = HexColor.fromHex("#CDD2D3");
  static Color error = HexColor.fromHex("#E61F34");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

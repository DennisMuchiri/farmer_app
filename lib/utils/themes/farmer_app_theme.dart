

import 'package:flutter/material.dart';

class FarmerAppTheme {
  FarmerAppTheme._();

  static Color green_open = HexColor('#4DBD74');
  static Color red_closed = HexColor('#F86C6B');

  //AVENIR
  static const String font_AvenirLTStd_Black = 'AvenirLTStd-Black';
  static const String font_AvenirLTStd_BlackOblique =
      'AvenirLTStd-BlackOblique';
  static const String font_AvenirLTStd_Book = 'AvenirLTStd-Book';
  static const String font_AvenirLTStd_BookOblique = 'AvenirLTStd-BookOblique';
  static const String font_AvenirLTStd_Heavy = 'AvenirLTStd-Heavy';
  static const String font_AvenirLTStd_HeavyOblique =
      'AvenirLTStd-HeavyOblique';
  static const String font_AvenirLTStd_Light = 'AvenirLTStd-Light';
  static const String font_AvenirLTStd_LightOblique =
      'AvenirLTStd-LightOblique';
  static const String font_AvenirLTStd_Medium = 'AvenirLTStd-Medium';
  static const String font_AvenirLTStd_MediumOblique =
      'AvenirLTStd-MediumOblique';
  static const String font_AvenirLTStd_Oblique = 'AvenirLTStd-Oblique';
  static const String font_AvenirLTStd_Roman = 'AvenirLTStd-Roman';

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

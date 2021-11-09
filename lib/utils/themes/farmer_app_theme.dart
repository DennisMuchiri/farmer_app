

import 'package:flutter/material.dart';

class FarmerAppTheme {
  FarmerAppTheme._();

  static Color green_open = HexColor('#4DBD74');
  static Color red_closed = HexColor('#F86C6B');
  static Color white = Colors.white;
  static Color red = Colors.red;
  static const Color grey = Color(0xFF3A5160);
  static const Color bg_purple_light = Color(0xFFE6EAF7);
  static const Color lma_purple = Color(0xFF6C66A9);
  static const Color transparent = Colors.transparent;
  static const Color lma_purple_2 = Color(0xFF404260);
  static const Color lma_blue_1 = Color(0xFF9CE7F2);
  static const Color lma_grey_op_05= Color(0xFF9FA8AF);
  static const Color darkText = Color(0xFF253840);

  static Color pltf_grey = Color(0xFF9E9E9E);
  static Color pltf_pink = Color(0xFFE91E63);
  static Color sm_bg_background = Color(0xFFF2F3F8);
  //AVENIR FONT
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

import 'package:farmer_app/utils/enums/screens.dart';
import 'package:flutter/material.dart';

class NavigationData {
  Object? selectedWidget;
  bool? isShow;
  ScreenIndex? screenIndex;
  bool? isInBackPressed;
  bool? isValid;
  String? message;

  NavigationData() {}
}

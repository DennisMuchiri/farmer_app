import 'package:flutter/widgets.dart';

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 800;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1200;
}

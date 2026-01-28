import 'package:flutter/material.dart';

class Responsive {
  // Check device type
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  // Get responsive font size
  static double fontSize(BuildContext context, double size) {
    if (isDesktop(context)) return size * 1.2;
    if (isTablet(context)) return size * 1.1;
    return size;
  }

  // Get responsive padding
  static double padding(BuildContext context) {
    if (isDesktop(context)) return 40.0;
    if (isTablet(context)) return 30.0;
    return 20.0;
  }

  // Get responsive icon size
  static double iconSize(BuildContext context, double size) {
    if (isDesktop(context)) return size * 1.2;
    if (isTablet(context)) return size * 1.1;
    return size;
  }
}

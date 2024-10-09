import 'package:flutter/material.dart';

class ResponsiveSize {
  static const double _smallScreenWidth = 600;
  static const double _mediumScreenWidth = 1200;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < _smallScreenWidth;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _smallScreenWidth &&
          MediaQuery.of(context).size.width < _mediumScreenWidth;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _mediumScreenWidth;

  static double getResponsiveValue({
    required BuildContext context,
    required double small,
    required double medium,
    required double large,
  }) {
    if (isSmallScreen(context)) return small;
    if (isMediumScreen(context)) return medium;
    return large;
  }
}
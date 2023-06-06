import "package:flutter/material.dart";

abstract class MyTheme {
  // sizes

  static const double smallSpaceSize = 10, bigSpaceSize = 20;

  static const double pageMaxWidth = 720;

  // paddings

  static const EdgeInsets cardPadding = EdgeInsets.all(24);

  // animations

  static const subpageTransitionDuration = Duration(milliseconds: 300);
  static const subpageTransitionInCurve = Curves.easeOutCubic;
  static const subpageTransitionOutCurve = Curves.easeInExpo;

  // theme data

  static final theme = ThemeData(
    useMaterial3: true,

    // color scheme
    colorSchemeSeed: const Color(0xFFCC00FF),
    brightness: Brightness.dark,

    // text
    fontFamily: "DMSans",

    // widgets' themes
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

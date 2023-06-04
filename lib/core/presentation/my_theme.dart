import "package:flutter/material.dart";

abstract class MyTheme {
  static const double smallSpaceSize = 10;
  static const double bigSpaceSize = 20;

  static const double pageMaxWidth = 720;

  static const EdgeInsets cardPadding = EdgeInsets.all(24);

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

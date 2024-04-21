import 'package:flutter/material.dart';

class UtahColorScheme {
  static const Color primary = Color.fromARGB(255, 134, 31, 31);
  static const Color secondary = Color.fromARGB(200, 80, 80, 80);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Brightness brightness = Brightness.light;

  static const ColorScheme colorScheme = ColorScheme(
    primary: primary,
    secondary: secondary,
    surface: surface,
    background: background,
    error: error,
    onPrimary: onPrimary,
    onSecondary: onSecondary,
    onSurface: onSurface,
    onBackground: onBackground,
    onError: onError,
    brightness: brightness,
  );

  static const List<Color> lotColors = [
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 255, 0, 0),
  ];

  static const List<Color> lotColorsColorblind = [
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 0, 255, 127),
    Color.fromARGB(255, 255, 255, 0),
  ];
}

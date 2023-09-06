import 'package:flutter/material.dart';

const dark = Color.fromARGB(255, 24, 24, 24);
const light = Colors.blue;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: light,
    onPrimary: Colors.white,
    secondary: dark,
    onSecondary: Colors.white,
    primaryContainer: light,
    error: Colors.black,
    onError: Colors.white,
    background: light,
    onBackground: Colors.white,
    surface: light,
    onSurface: Colors.white,
  ),
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: dark,
    onPrimary: Colors.white,
    secondary: dark,
    onSecondary: Colors.white,
    primaryContainer: dark,
    error: Colors.black,
    onError: Colors.white,
    background: dark,
    onBackground: Colors.white,
    surface: dark,
    onSurface: Colors.white,
  ),
);

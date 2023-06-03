import 'package:flutter/material.dart';
part 'dark_theme_color.dart';

class DarkTheme {
  static ThemeData themeData(context) {
    return ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        primaryColor: primaryColor,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: labelColor),
          labelMedium: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: labelColor),
          labelSmall: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
          displayLarge: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: labelColor),
          displayMedium: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
          displaySmall: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold, color: labelColor),
          bodyLarge: TextStyle(fontSize: 16.0, color: labelColor),
          bodyMedium: TextStyle(fontSize: 14.0, color: labelColor),
          bodySmall: TextStyle(fontSize: 12.0, color: labelColor),
          titleLarge: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: labelColor),
          titleMedium: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: labelColor),
          titleSmall: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
part 'light_theme_color.dart';

class LightTheme {
  static ThemeData themeData(context) {
    const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      contentPadding: EdgeInsets.all(10),
      iconColor: primaryColor,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8, color: primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8, color: primaryColor)),
    );
    String _selectedFontFamily = 'Tondo';
    return ThemeData.light().copyWith(
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionHandleColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: labelColor, circularTrackColor: Colors.grey),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.grey.shade800),
          toolbarTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              fontFamily: _selectedFontFamily),
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: _selectedFontFamily),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: Platform.isIOS
              ? const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                )
              : const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                ),
        ),
        primaryColor: primaryColor,
        textTheme: TextTheme(
          // labelLarge: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 18.0,
          //     color: labelColor),
          // labelMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 16.0,
          //     color: labelColor),
          // labelSmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     color: labelColor),
          // displayLarge: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // displayMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // displaySmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          bodyLarge: TextStyle(
              fontFamily: _selectedFontFamily,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
              color: labelColor),
          bodyMedium: TextStyle(
              fontFamily: _selectedFontFamily,
              fontSize: 14.0,
              color: labelColor),
          bodySmall: TextStyle(
              fontFamily: _selectedFontFamily,
              fontSize: 12.0,
              color: labelColor),
          headlineSmall: const TextStyle(
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
            fontSize: 25.0,
          ),
          titleLarge: TextStyle(
              fontFamily: _selectedFontFamily,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: labelColor),
          // titleMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // titleSmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
        ));
  }
}

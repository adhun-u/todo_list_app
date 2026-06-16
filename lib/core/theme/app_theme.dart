import 'package:flutter/material.dart';

class AppTheme {
  static final lightPrimary = Color(0xFFFFFFFF);
  static final lightSecondary = Color(0xFFF0F1F1);
  static final lightCard = Color(0xFFE2E2E2);
  static final lightButton = Color(0xFF000000);

  static final darkPrimary = Color(0xFF000000);
  static final darkSecondary = Color(0xFF1B1B1B);
  static final darkCard = Color(0xFF303030);
  static final darkButton = Color(0xFFFFFFFF);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightPrimary,
    cardColor: lightCard,
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(lightButton),
        iconColor: WidgetStatePropertyAll(lightPrimary),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightButton,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkPrimary,
      selectionColor: lightSecondary,
      selectionHandleColor: darkPrimary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkPrimary,
    canvasColor: darkCard,
    colorScheme: ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkPrimary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(darkButton),
        iconColor: WidgetStatePropertyAll(darkPrimary),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkButton,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightPrimary,
      selectionColor: darkSecondary,
      selectionHandleColor: lightPrimary,
    ),
  );
}

extension CustomColorScheme on BuildContext {
  ColorScheme get colorScheme => ColorScheme.of(this);
}

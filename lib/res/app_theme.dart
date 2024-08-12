import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF8343); // Vibrant Orange
  static const Color lightColor = Color(0xFFF1DEC6); // Soft Cream
  static const Color accentColor = Color(0xFF179BAE); // Fresh Teal
  static const Color darkColor = Color(0xFF4158A6); // Strong Blue

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: accentColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColor,
        centerTitle: true,
        titleTextStyle: TextStyle(color: lightColor, fontSize: 20),
      ),
      textTheme: GoogleFonts.ubuntuTextTheme(TextTheme(
        displayLarge: TextStyle(color: darkColor, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: darkColor, fontWeight: FontWeight.bold, fontSize: 25),
        titleLarge: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(color: darkColor, fontSize: 20),
        bodyLarge: TextStyle(color: darkColor, fontSize: 20),
        bodyMedium: TextStyle(color: darkColor, fontSize: 16),
        bodySmall: TextStyle(color: darkColor, fontSize: 13),
        labelLarge: TextStyle(color: accentColor, fontSize: 16),
      )),
      iconTheme: IconThemeData(color: lightColor, size: 18),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: darkColor.withOpacity(0.5), fontSize: 16),
        labelStyle: TextStyle(color: primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColor, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkColor,
        brightness: Brightness.light,
      ),
    );
  }
}

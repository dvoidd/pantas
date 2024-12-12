import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getDefaultTheme() {
  return ThemeData(
      textTheme: GoogleFonts.spaceGroteskTextTheme(),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.white));
}

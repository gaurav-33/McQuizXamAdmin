
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.blumineBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 24,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 19,
    blendOnColors: false,
    useTextTheme: true,
    inputDecoratorBackgroundAlpha: 109,
    inputDecoratorRadius: 6.0,
    cardRadius: 20.0,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    snackBarRadius: 10,
    snackBarElevation: 12,
    bottomSheetBackgroundColor: SchemeColor.primaryContainer,
    bottomSheetModalBackgroundColor: SchemeColor.onPrimary,
    bottomSheetRadius: 1.0,
    bottomSheetElevation: 2.0,
    bottomSheetModalElevation: 2.0,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.notoSans().fontFamily,
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blumineBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    inputDecoratorRadius: 6.0,
    cardRadius: 20.0,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    snackBarRadius: 10,
    snackBarElevation: 12,
    bottomSheetBackgroundColor: SchemeColor.primaryContainer,
    bottomSheetModalBackgroundColor: SchemeColor.onPrimary,
    bottomSheetRadius: 1.0,
    bottomSheetElevation: 2.0,
    bottomSheetModalElevation: 2.0,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.notoSans().fontFamily,
);

import 'package:flutter/material.dart';
import '../const/palette.dart';
import '../const/styles.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Palette.themeColor,
  colorScheme: const ColorScheme.light(
    primary: Palette.themeColor,
    secondary: Palette.themeColor,
    background: Palette.lightBackgroundColor,
  ),
  scaffoldBackgroundColor: Palette.whiteColor,
  textTheme: TextTheme(
    displayLarge: largeHeadlineTextStyle(Palette.blackColor),
    titleLarge: subheadingTextStyle(Palette.blackColor),
    bodyLarge: primaryBodyTextStyle(Palette.blackColor),
    bodyMedium: secondaryBodyTextStyle(Palette.blackColor),
    labelLarge: primaryButtonTextStyle(Palette.whiteColor),
    bodySmall: captionTextStyle(Palette.greyColor),
    labelSmall: overlineTextStyle(Palette.greyColor),
    headlineLarge: largeHeadlineTextStyle(Palette.blackColor),
    titleMedium: subtitleTextStyle(Palette.blackColor),
  ),
  iconTheme: primaryIconThemeData(Palette.iconColor),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    filled: true,
    fillColor: Palette.lightGreyColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: primaryElevatedButtonStyle(Palette.whiteColor, Palette.themeColor),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: primaryOutlinedButtonStyle(Palette.themeColor, Palette.themeColor),
  ),
  textButtonTheme: TextButtonThemeData(
    style: primaryTextButtonStyle(Palette.themeColor),
  ),
);

final ThemeData darkTheme = ThemeData(
    primaryColor: Palette.themeColor,
    colorScheme: const ColorScheme.dark(
      primary: Palette.themeColor,
      secondary: Palette.themeColor,
      background: Palette.darkBackgroundColor,
    ),
    scaffoldBackgroundColor: Palette.darkBackgroundColor,
    textTheme: TextTheme(
      displayLarge: largeHeadlineTextStyle(Palette.whiteColor),
      titleLarge: subheadingTextStyle(Palette.whiteColor),
      bodyLarge: primaryBodyTextStyle(Palette.whiteColor),
      bodyMedium: secondaryBodyTextStyle(Palette.whiteColor),
      labelLarge: primaryButtonTextStyle(Palette.whiteColor),
      bodySmall: captionTextStyle(Palette.greyColor),
      labelSmall: overlineTextStyle(Palette.greyColor),
      headlineLarge: largeHeadlineTextStyle(Palette.whiteColor),
      titleMedium: subtitleTextStyle(Palette.whiteColor),
    ),
    iconTheme: primaryIconThemeData(Palette.iconColor),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      filled: true,
      fillColor: Palette.greyColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryElevatedButtonStyle(Palette.whiteColor, Palette.themeColor),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: primaryOutlinedButtonStyle(Palette.whiteColor, Palette.themeColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: primaryTextButtonStyle(Palette.whiteColor),
    ));

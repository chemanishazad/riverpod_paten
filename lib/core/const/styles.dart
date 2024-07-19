import 'package:flutter/material.dart';
import 'palette.dart';

// Text Styles
TextStyle headingTextStyle(Color color) => TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: color,
);

TextStyle subheadingTextStyle(Color color) => TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w600,
  color: color,
);

TextStyle primaryBodyTextStyle(Color color) => TextStyle(
  fontSize: 15.0,
  color: color,
  fontWeight: FontWeight.w500,
);

TextStyle secondaryBodyTextStyle(Color color) => TextStyle(
  fontSize: 15.0,
  color: color,
);

TextStyle primaryButtonTextStyle(Color color) => TextStyle(
  fontSize: 15.0,
  color: color,
  fontWeight: FontWeight.w500,
);

TextStyle captionTextStyle(Color color) => TextStyle(
  fontSize: 14.0,
  color: color,
);

TextStyle overlineTextStyle(Color color) => TextStyle(
  fontSize: 12.0,
  color: color,
  fontWeight: FontWeight.w400,
);

TextStyle largeHeadlineTextStyle(Color color) => TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: color,
);

TextStyle subtitleTextStyle(Color color) => TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: color,
);

// Box Decorations
BoxDecoration primaryBoxDecoration(Color color) => BoxDecoration(
  color: color,
  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  boxShadow: const [
    BoxShadow(
      color: Palette.greyColor,
      blurRadius: 5.0,
      spreadRadius: 1.0,
      offset: Offset(2.0, 2.0),
    ),
  ],
);

BoxDecoration secondaryBoxDecoration(Color color) => BoxDecoration(
  color: color,
  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  boxShadow: const [
    BoxShadow(
      color: Palette.greyColor,
      blurRadius: 3.0,
      spreadRadius: 1.0,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

// Input Decorations
InputDecoration primaryInputDecoration(Color color) => InputDecoration(
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  filled: true,
  fillColor: color,
  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
);

InputDecoration searchInputDecoration(Color color) => InputDecoration(
  hintText: 'Search...',
  prefixIcon: const Icon(Icons.search, color: Palette.iconColor),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  filled: true,
  fillColor: color,
  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
);

// Button Styles
ButtonStyle primaryElevatedButtonStyle(Color foregroundColor, Color backgroundColor) => ElevatedButton.styleFrom(
  foregroundColor: foregroundColor,
  backgroundColor: backgroundColor,
  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  textStyle: primaryButtonTextStyle(foregroundColor),
);

ButtonStyle primaryOutlinedButtonStyle(Color foregroundColor, Color sideColor) => OutlinedButton.styleFrom(
  foregroundColor: foregroundColor,
  side: BorderSide(color: sideColor),
  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  textStyle: primaryButtonTextStyle(foregroundColor),
);

ButtonStyle primaryTextButtonStyle(Color foregroundColor) => TextButton.styleFrom(
  foregroundColor: foregroundColor,
  textStyle: primaryButtonTextStyle(foregroundColor),
);

// Icon Themes
IconThemeData primaryIconThemeData(Color color) => IconThemeData(
  color: color,
  size: 24.0,
);

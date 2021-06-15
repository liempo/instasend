import 'package:flutter/material.dart';

import 'swatch_generator.dart';

final brandColor = Color(0xff6d287b);
final accentColor = Color(0xffb8d8fe);
final brandSwatch = createSwatch(brandColor);

final textTheme = TextTheme(
  subtitle1: TextStyle(
    fontWeight: FontWeight.bold
  )
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: brandSwatch,
  accentColor: accentColor,
  textTheme: textTheme,
  primaryTextTheme: textTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton
      .styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ))
  )
);
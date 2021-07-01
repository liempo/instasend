import 'package:flutter/material.dart';

import 'swatch_generator.dart';

final brandColor = Color(0xff6d287b);
final accentColor = Color(0xffb8d8fe);
final brandSwatch = createSwatch(brandColor);


final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: brandSwatch,
  accentColor: accentColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton
      .styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ))
  )
);

final headerBorderRadius = 32.0;
final cardBorderRadius = 12.0;

final emailRegex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
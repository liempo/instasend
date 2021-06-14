import 'package:flutter/material.dart';

import 'material_color_generator.dart';

final brandColor = Color(0xff6d287b);
final accentColor = Color(0xffb8d8fe);
final brandSwatch = createMaterialColor(brandColor);

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
      .styleFrom(shape: StadiumBorder())
  )
);

final headerCornerRadius
  = Radius.circular(32);
import 'package:flutter/material.dart';

extension ImageExtension on Image {

  Widget withTint({required Color color}) {
    return ColorFiltered(
      child: this,
      colorFilter: ColorFilter.mode(
        color, BlendMode.srcATop
      )
    );
  }

}
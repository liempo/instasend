import 'package:flutter/material.dart';

import '/utils/image_extension.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logos/circle.png',
          height: 128, width: 128
        ).withTint(
          color: Theme.of(context)
            .primaryColor
        ),
      )
    );
  }
}
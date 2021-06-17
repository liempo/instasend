import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '/ui/auth/auth_screen.dart';
import '/utils/image_extension.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Get firebase's connection state
        final state = snapshot.connectionState;
        // Decide what screen to show based on state
        if (state == ConnectionState.done)
          return AuthScreen.withViewModel();
        // Show splash screen while firebase
        // connection is not yet established
        return Scaffold(
          backgroundColor: Theme.of(context)
            .accentColor,
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
      },
    );
  }

}
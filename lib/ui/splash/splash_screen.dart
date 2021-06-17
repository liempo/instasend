import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '/ui/auth/auth_screen.dart';
import '/utils/image_extension.dart';
import '/view_models/splash_model.dart';

class SplashScreen extends StatelessWidget {

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => SplashModel(),
      builder: (context, child) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Get firebase's connection state
        final state = snapshot.connectionState;

        // Decide what screen to show based on state
        if (state == ConnectionState.done)
          return Consumer<SplashModel>(
            builder: (context, value, child) {
              if (!value.isAuthenticated)
                return AuthScreen.withViewModel();
              return Container();
            },
          );

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
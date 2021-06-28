import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '/ui/auth/auth_screen.dart';
import '/ui/home/home_screen.dart';
import '/utils/locator.dart';
import '/repositories/auth_repository.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState()
    => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  // Do not call 'initializeApp' directly under build
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {

        // Get firebase's connection state
        final state = snapshot.connectionState;

        // Decide what screen to show based on state
        if (state == ConnectionState.done) {
          final _auth = repos<AuthRepository>();

          // Show a screen based on authState
          return (_auth.user != null) ?
            HomeScreen.withViewModel() :
            AuthScreen.withViewModel();
        }

        // Show a blank page while firebase is initializing
        return Container(
          color: Theme.of(context)
            .canvasColor
        );

      },
    );
  }
}
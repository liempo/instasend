import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '/utils/constants.dart';
import '/ui/auth/auth_screen.dart';
import '/ui/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding
    .ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Firebase future initialization
  final Future<FirebaseApp> _initialization
    = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instasend',
      theme: lightTheme,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Get firebase's connection state
          final state = snapshot.connectionState;
          // Decide what screen to show based on state
          if (state == ConnectionState.done)
            return AuthScreen.withProvider();
          return SplashScreen();
        },
      )
    );
  }

}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instasend/utils/constants.dart';

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

  final materialApp = MaterialApp(
    title: 'Instasend',
    theme: lightTheme,
    home: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Get firebase's connection state
        final state = snapshot.connectionState;

        // Decide what screen to show based on state
        if (state == ConnectionState.done)
          return materialApp;
        return Container();
      }
    );
  }
}

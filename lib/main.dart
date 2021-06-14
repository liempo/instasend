import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
    title: 'Flutter Demo',
    home: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return materialApp;

        return Container();
      }
    );
  }
}

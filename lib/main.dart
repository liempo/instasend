import 'package:flutter/material.dart';

import '/utils/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instasend',
      theme: lightTheme,
      home: SplashScreen()
    );
  }

}

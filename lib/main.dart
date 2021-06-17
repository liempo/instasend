import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/utils/repo_locator.dart';
import '/ui/splash/splash_screen.dart';

void main() {
  // Setup the repository locator
  setupRepositoryLocator();

  // Ensure bindings are initialized
  WidgetsFlutterBinding
    .ensureInitialized();

  // Start the app
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
      home: SplashScreen
        .withViewModel()
    );
  }
}

import 'package:flutter/material.dart';

import '/utils/constants.dart';
import 'ui/loading/loading_screen.dart';

void main() {

  // Ensure bindings are initialized
  WidgetsFlutterBinding
    .ensureInitialized();

  // Start the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instasend',
      theme: lightTheme,
      home: LoadingScreen()
    );
  }
}

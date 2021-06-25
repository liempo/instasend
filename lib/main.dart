import 'package:flutter/material.dart';

import 'ui/loading/loading_screen.dart';
import '/utils/constants.dart';
import '/utils/repo_locator.dart';

void main() {
  // Setup the repository locator
  setupRepositoryLocator();

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

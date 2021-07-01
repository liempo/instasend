import 'package:flutter/material.dart';

import '/ui/loading/loading_screen.dart';
import '/ui/auth/auth_screen.dart';
import '/ui/home/home_screen.dart';
import '/utils/constants.dart';
import '/utils/locator.dart';
import '/services/nav_service.dart';

void main() {
  // Setup the locators
  setupRepositoryLocator();
  setupServiceLocator();

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
      home: LoadingScreen(),
      onGenerateRoute: _onGenerateRoute,
      navigatorKey: services<NavigationService>()
        .navigatorKey,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'auth': return MaterialPageRoute(
        builder: (context) => AuthScreen
        .withViewModel());
      case 'home': return MaterialPageRoute(
        builder: (context) => HomeScreen
        .withViewModel());

      // Defaults to login screen
      default: return MaterialPageRoute(
        builder: (context) => AuthScreen
          .withViewModel());
    }
  }

}

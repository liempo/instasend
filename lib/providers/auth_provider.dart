import 'package:flutter/material.dart';
import '/models/auth_type.dart';

class AuthProvider extends ChangeNotifier {

  // Determines what form to show in the UI
  AuthType _type = AuthType.LOGIN;
  AuthType get type => _type;

  // Swaps forms depending on what's visible
  void swap() {
    switch (_type) {
      case AuthType.LOGIN:
        _type = AuthType.REGISTER; break;
      case AuthType.REGISTER:
        _type = AuthType.LOGIN; break;
      case AuthType.RECOVER:
        _type = AuthType.LOGIN; break;
    }

    notifyListeners();
  }

  void setTypeToRecover() {
    _type = AuthType.RECOVER;
    notifyListeners();
  }

  String getPrimaryButtonText() {
    switch (_type) {
      case AuthType.LOGIN:
        return "Login";
      case AuthType.REGISTER:
        return "Register";
      case AuthType.RECOVER:
        return "Recover";
    }
  }

  String getAlternateButtonText() {
    switch (_type) {
      case AuthType.LOGIN:
        return "Don't have an account yet?";
      case AuthType.REGISTER:
        return "Already have an account?";
      case AuthType.RECOVER:
        return "Go back to logging in";
    }
  }

}
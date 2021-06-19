import 'package:flutter/foundation.dart';

import '/repositories/auth_repository.dart';
import '/models/auth_type.dart';
import '/utils/repo_locator.dart';
import '/utils/constants.dart';

class AuthModel extends ChangeNotifier {

  final _auth = repos<AuthRepository>();

  // These are form contents which are
  // unified across all forms
  String? _email;
  set email(String text)
    => _email = text;
  String? _errorEmail;
  get errorEmail => _errorEmail;
  String? _password;
  set password(String text)
    => _password = text;
  String? _errorPassword;
  get errorPassword => _errorPassword;

  // Determines what form to show in the UI
  AuthType _type = AuthType.LOGIN;
  AuthType get type => _type;

  // Binded to disable some widgets
  bool _isLoading = false;
  get isLoading => _isLoading;

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

    // Clear error text every time user swaps
    _errorEmail = null;
    _errorPassword = null;

    notifyListeners();
  }

  void setTypeToRecover() {
    _type = AuthType.RECOVER;
    notifyListeners();
  }

  void confirmPassword(String confirm) {
    if (_password != confirm)
      _errorPassword = "Password does not match";
    else _errorPassword = null;
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

  bool _checkFormValid() {
    // Email field validations
    if (_email == null || _email == "")
      _errorEmail = "Email cannot be empty";
    else if (!emailRegex.hasMatch(_email!))
      _errorEmail = "Please provide a valid email";
    else _errorEmail = null;

    // Password field validations
    if (_password == null || _password == "")
      _errorPassword = "Password cannot be empty";
    else _errorPassword = null;


    // NOTE: _errorPassword and _errorEmail being null
    // means they are valid and authentication is good to go
    return _errorEmail == null && _errorPassword == null;
  }

  void submit() async {
    // Set Widgets to loading state
    _isLoading = true;

    // Validate inputs
    if (!_checkFormValid()) {
      // Update error texts as well as loading state
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Add a ! notation because I know that these strings
    // are not null because of _checkFormValid()
    var email = _email!;
    var password = _password!;

    String result;
    switch (_type) {
      case AuthType.LOGIN:
        result = await _auth.login(
          email: email,
          password: password);
        break;
      case AuthType.REGISTER:
        result = await _auth.register(
          email: email,
          password: password);
        break;
      case AuthType.RECOVER:
        result = await _auth.recover(
          email: email);
        break;
    }

    if (result != 'success')
      _errorEmail = result;
    _isLoading = false;
    notifyListeners();
  }

}
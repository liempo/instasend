import 'package:flutter/foundation.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';
import '/models/auth_type.dart';
import '/models/profile.dart';
import '/utils/repo_locator.dart';
import '/utils/constants.dart';
import '/utils/string_extension.dart';

class AuthModel extends ChangeNotifier {

  final _auth = repos<AuthRepository>();
  final _profiles = repos<ProfileRepository>();

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

  // Profile form contents, to be used
  //when ProfileForm is active
  String? _firstName;
  set firstName(String text)
    => _firstName = text;
  String? _errorFirstName;
  get errorFirstName => _errorFirstName;
  String? _lastName;
  set lastName(String text)
    => _lastName = text;
  String? _errorLastName;
  get errorLastName => _errorLastName;
  ProfileType _profileType = ProfileType.STANDARD;

  // Determines what form to show in the UI
  AuthType _authType = AuthType.PROFILE;
  AuthType get type => _authType;

  // Binded to disable some widgets
  bool _isLoading = false;
  get isLoading => _isLoading;

  // Get String formatted profileType
  String get profileType => _profileType.toBetterString();

  // Search for name of type in ProfileType enum
  // NOTE: Needs to be declared as a func so it can be passed in onChanged
  void setProfileType(String? text) {
    // Ignore call if text is null
    if (text == null) return;

    for (var type in ProfileType.values) {
      if (type.toString().contains(text.toLowerCase())) {
        _profileType = type; break;
      }
    }
  }

  // Get the list of profile as String
  List<String> getProfileTypeList() => ProfileType.values.map((e) {
    return e.toBetterString().capitalize();
  }).toList();

  // Swaps forms depending on what's visible
  void swap() {
    switch (_authType) {
      case AuthType.LOGIN:
        _authType = AuthType.REGISTER; break;
      case AuthType.REGISTER:
        _authType = AuthType.LOGIN; break;
      case AuthType.RECOVER:
        _authType = AuthType.LOGIN; break;
      case AuthType.PROFILE:
        _authType = AuthType.LOGIN; break;
    }

    // Clear error text every time user swaps
    _errorEmail = null;
    _errorPassword = null;

    notifyListeners();
  }

  void setTypeToRecover() {
    _authType = AuthType.RECOVER;
    notifyListeners();
  }

  void confirmPassword(String confirm) {
    if (_password != confirm)
      _errorPassword = "Password does not match";
    else _errorPassword = null;
    notifyListeners();
  }

  String getPrimaryButtonText() {
    switch (_authType) {
      case AuthType.LOGIN:
        return "Login";
      case AuthType.REGISTER:
        return "Register";
      case AuthType.RECOVER:
        return "Recover";
      case AuthType.PROFILE:
        return "Finish";
    }
  }

  String getAlternateButtonText() {
    switch (_authType) {
      case AuthType.LOGIN:
        return "Don't have an account yet?";
      case AuthType.REGISTER:
        return "Already have an account?";
      case AuthType.RECOVER:
        return "Go back to logging in";
      case AuthType.PROFILE:
        return "Log in  to a different account";
    }
  }

  bool _checkFormValid() {
    // Profile field validations
    if (_authType == AuthType.PROFILE) {
      if (_firstName == null || _firstName == "")
        _errorFirstName = "First name cannot be empty";
      if (_lastName == null || _lastName == "")
        _errorLastName = "Last name cannot be empty";
      // Do not check ProfileType because it defaults to STANDARD

      return _errorFirstName == null && _errorLastName == null;
    } // Else:

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

    // Create switch for firebase call
    String result;
    switch (_authType) {
      case AuthType.LOGIN:
        result = await _auth.login(
          email: _email!,
          password: _password!
        ); break;
      case AuthType.REGISTER:
        result = await _auth.register(
          email: _email!,
          password: _password!
        ); break;
      case AuthType.RECOVER:
        result = await _auth.recover(
          email: _email!
        ); break;
      case AuthType.PROFILE:
        result = await _profiles
          .createProfile(
          uid: (await _auth.user.last)!.uid,
          profile: Profile(
            firstName: _firstName!,
            lastName: _lastName!,
            type: _profileType
          )
        ); break;
    }

    // Update UI again if problem occurs
    if (result != 'success')
      _errorEmail = result;
    _isLoading = false;
    notifyListeners();

    // Create another switch for routes
    switch (_authType) {
      case AuthType.LOGIN:
        break;
      case AuthType.REGISTER:
        _authType = AuthType.PROFILE; break;
      case AuthType.RECOVER:
        break;
      case AuthType.PROFILE:
        break;
    }

  }

}
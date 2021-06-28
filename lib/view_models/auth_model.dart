import 'package:flutter/widgets.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';
import '/services/nav_service.dart';
import '/models/auth_type.dart';
import '/models/profile.dart';
import '/utils/locator.dart';
import '/utils/constants.dart';
import '/utils/string_extension.dart';

class AuthModel extends ChangeNotifier {

  final _nav = services<NavigationService>();
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

  // Authentication message for errors and stuff
  String? _errorAuth;
  get errorAuth => _errorAuth;

  // Determines what form to show in the UI
  AuthType _authType = AuthType.REGISTER;
  AuthType get type => _authType;

  // Binded to disable some widgets
  bool _isLoading = false;
  get isLoading => _isLoading;

  // Get String formatted profileType
  String? get profileType
    => _profileType.toBetterString();

  // Search for name of type in ProfileType enum
  // NOTE: Needs to be declared as a func so it can be passed in onChanged
  void setProfileType(String? text) {
    // Ignore call if text is null
    if (text == null) return;
    _profileType = ProfileTypeExtension
      .fromBetterString(text);
    notifyListeners();
  }

  // Get the list of profile as String
  List<String> getProfileTypeList() =>
    ProfileType.values.map((e) {
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
    _errorFirstName = null;
    _errorLastName = null;
    _errorAuth = null;

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
      else _errorFirstName = null;

      if (_lastName == null || _lastName == "")
        _errorLastName = "Last name cannot be empty";
      else _errorLastName = null;
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

  void _login() async {
    final result = await _auth.login(
      email: _email!, password: _password!);

    if (result == 'success') {
      final profile = await _profiles
        .getProfile(uid: _auth.user!.uid);

      if (profile == null) {
        _authType = AuthType.PROFILE;
        notifyListeners(); return;
      }

      _nav.pushReplacementNamed('home');
    } else {
      _errorAuth = result;
      notifyListeners(); return;
    }

  }

  void _register() async {
    final result = await _auth.register(
      email: _email!, password: _password!);

    // Update error msg if exist
    if (result != 'success')
      _errorAuth = result;
    else
      // Upadte form to show
      _authType = AuthType.PROFILE;

    notifyListeners();
  }

  void _recover() async {
    final result = await _auth.recover(
      email: _email!);
    if (result != 'success')
      _errorAuth = result;
    notifyListeners();
  }

  void _createProfile() async {
    // Do not proceed if no user signed in
    if (_auth.user == null)
      return;

    final uid = _auth.user!.uid;
    final result = await _profiles
      .createProfile(
      uid: uid,
      profile: Profile(
        firstName: _firstName!,
        lastName: _lastName!,
        type: _profileType
      )
    );

    if (result != 'success') {
      _errorAuth = result;
      notifyListeners(); return;
    }

    _nav.pushReplacementNamed('home');
  }

  void submit() async {
    // Return if called while loading
    if (_isLoading) return;

    // Reset error msgs
    _errorAuth = null;

    // Set Widgets to loading state
    _isLoading = true;

    // Update with pre
    notifyListeners();

    // Validate inputs
    if (!_checkFormValid()) {
      _isLoading = false;

      // Update error texts (modified in _checkFormValid())
      notifyListeners();
      return;
    }

    // Create switch for firebase call
    switch (_authType) {
      case AuthType.LOGIN:
        _login(); break;
      case AuthType.REGISTER:
        _register(); break;
      case AuthType.RECOVER:
        _recover(); break;
      case AuthType.PROFILE:
        _createProfile(); break;
    }

    // Delay turning off loading by 500ms
    Future.delayed(
      Duration(milliseconds: 500),
        () {
        _isLoading = false;
        notifyListeners();
      }
    );
  }

}
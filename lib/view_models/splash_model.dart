import 'package:flutter/material.dart';

import '/utils/repo_locator.dart';
import '/repositories/auth_repository.dart';

class SplashModel extends ChangeNotifier {

  final _auth = repos<AuthRepository>();

  var _isAuthenticated = false;
  get isAuthenticated => _isAuthenticated;

  SplashModel() {
    _auth.user.listen(_setAuthtenticated);
  }

  void _setAuthtenticated(user) {
    _isAuthenticated = user != null;
  }

}
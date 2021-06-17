import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {

  // Save the firebase auth instance
  var _auth = FirebaseAuth.instance;

  // Create account using email and password
  Future<void> register({
    required String email,
    required String password
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    } catch (e) { print(e); }
  }

  // Authenticate using email and password
  Future<void> login({
    required String email,
    required String password
  }) async {
    try {
      // Send login information to firebase
      await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    } catch (e) { print(e); }
  }

  Future<void> logout() async {
    _auth.signOut();
  }

}
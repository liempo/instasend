import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {

  // Save the firebase auth instance
  var _auth = FirebaseAuth.instance;

  // Using Stream to listen to Firebase user
  Stream<User?> get userStream =>
    _auth.authStateChanges();

  // Get Firebase user directly
  User? get user => _auth.currentUser;

  // Create account using email and password
  Future<String> register({
    required String email,
    required String password
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        return 'The password provided is too weak';
      else if (e.code == 'email-already-in-use')
        return 'The account already exists for that email';
      else if (e.code == 'weak-password')
        return 'the password is too weak.';
    } catch (e) { return e.toString(); }

    return 'success';
  }

  // Authenticate using email and password
  Future<String> login({
    required String email,
    required String password
  }) async {
    try {
      // Send login information to firebase
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'Account is not found';
    } else if (e.code == 'wrong-password')
      return 'Wrong password provided';
    } catch (e) { return e.toString(); }
    // No exceptions
    return 'success';
  }

  Future<void> logout() async {
    _auth.signOut();
  }

  // TODO
  Future<String> recover({
    required String email
  }) async {
    return 'This is a work in progress.';
  }

}
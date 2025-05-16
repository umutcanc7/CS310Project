import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email and password
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("Email already in use.");
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'This email is already registered. Please use a different email.',
        );
      } else {
        print("Registration Error: \$e");
        throw FirebaseAuthException(
          code: e.code,
          message: e.message,
        );
      }
    } catch (e) {
      print("Registration Error: \$e");
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as CustomAuthProvider;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login user with email and password
  Future<User?> loginWithEmail(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store user data in the Provider
        Provider.of<CustomAuthProvider.AuthProvider>(context, listen: false).setUser(user);
        return user;  // Only return user if login is successful
      } else {
        throw Exception("User is null. Login failed.");
      }

    } on FirebaseAuthException catch (e) {
      print("Error Code: ${e.code}");

      if (e.code == 'user-not-found' || 
          e.code == 'wrong-password' || 
          e.code == 'invalid-credential') {
        throw FirebaseAuthException(
          code: 'invalid-credentials',
          message: 'Incorrect email or password. Please try again.',
        );
      } else if (e.code == 'invalid-email') {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email format is incorrect. Please enter a valid email address.',
        );
      } else {
        throw FirebaseAuthException(
          code: e.code,
          message: 'An unexpected error occurred. Please try again.',
        );
      }
    } catch (e) {
      print("Unexpected Login Error: $e");
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }
}

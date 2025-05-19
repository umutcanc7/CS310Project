import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_styles.dart';
import 'package:projephase2/services/login_backend.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool showPassword = false;
  bool rememberMe = false;

  Future<void> _showSnackbar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      User? user = await AuthService().loginWithEmail(context, email, password);


      if (user != null) {
        _showSnackbar('Login successful!');
        Navigator.pushNamed(context, '/Home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackbar('No user found with this email.');
      } else if (e.code == 'wrong-password') {
        _showSnackbar('Incorrect password. Please try again.');
      } else {
        _showSnackbar(e.message ?? 'An unexpected error occurred.');
      }
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "SABANCI SEPETİ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/sepet.jpg', height: 150),
                  const SizedBox(height: 30),

                  // Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Please enter your E-mail address",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    onSaved: (value) => email = value ?? '',
                  ),
                  const SizedBox(height: 10),

                  // Password Field
                  TextFormField(
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      hintText: "Please enter your password",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => password = value ?? '',
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text("LOGIN"),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Register');
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import '../app_styles.dart';
import 'package:projephase2/services/auth_service.dart';
import 'package:projephase2/services/database_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool showPassword = false;
  bool showConfirmPassword = false;
  String confirmPasswordError = '';

  final AuthService authService = AuthService();
  final DatabaseService databaseService = DatabaseService();

  Future<void> _showSnackbar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  Future<void> _registerUser() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      confirmPasswordError = '';
    });

    if (password != confirmPassword) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      return;
    }

    try {
      var user = await authService.registerWithEmail(email, password);

      if (user != null) {
        String userId = user.uid;
        await databaseService.addUser(userId, name, surname, email);
        _showSnackbar('Registration successful!');
        Navigator.pushNamed(context, '/Login');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showSnackbar('This email is already registered. Please use a different email.');
      } else {
        _showSnackbar(e.message ?? 'An error occurred.');
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
              autovalidateMode: AutovalidateMode.disabled,
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

                  // Name Field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                  ),
                  const SizedBox(height: 10),

                  // Surname Field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your surname",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Surname is required';
                      }
                      return null;
                    },
                    onSaved: (value) => surname = value!,
                  ),
                  const SizedBox(height: 10),

                  // Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Enter your email",
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
                    onSaved: (value) => email = value!,
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
                          setState(() => showPassword = !showPassword);
                        },
                      ),
                      hintText: "Enter your password",
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
                    onSaved: (value) => password = value!,
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password Field
                  TextFormField(
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() => showConfirmPassword = !showConfirmPassword);
                        },
                      ),
                      hintText: "Confirm your password",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onSaved: (value) => confirmPassword = value!,
                  ),
                  
                  // Password Match Error
                  if (confirmPasswordError.isNotEmpty)
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 5, left: 12),
                      child: Text(
                        confirmPasswordError,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Register Button
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text("REGISTER"),
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

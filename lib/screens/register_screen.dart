import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import '../app_styles.dart';

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

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/sepet.jpg', height: 150),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Please enter your name",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave name empty';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => name = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Please enter your surname",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Surname is required' : null,
                  onSaved: (value) => surname = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Please enter your E-mail address",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => email = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() => showPassword = !showPassword);
                      },
                    ),
                    hintText: "Please enter your password",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave password empty';
                      }
                      if (value.length < 6) {
                        return 'Too short';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => password = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !showConfirmPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() => showConfirmPassword = !showConfirmPassword);
                      },
                    ),
                    hintText: "Please re-enter your password",
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Confirmation required';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => confirmPassword = value ?? '',
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Login');
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (password != confirmPassword) {
                        _showDialog(
                            'Password Mismatch', 'Passwords do not match');
                        return;
                      }

                      Navigator.pushNamed(context, '/Home');
                      print(
                          'Name: $name, Surname: $surname, Email: $email, Password: $password');
                    } else {
                      _showDialog('Form Error', 'Your form is invalid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15)),
                  child: const Text("REGISTER"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
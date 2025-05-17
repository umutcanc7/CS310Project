import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/profile_backend.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  Map<String, String?> _userData = {
    'name': "Not Provided",
    'surname': "Not Provided",
    'phone': "Not Provided",
    'email': "Not Provided"
  };

  User? get user => _user;
  Map<String, String?> get userData => _userData;

  void setUser(User user) async {
    _user = user;
    await _fetchUserData(user.uid);
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _userData = {
      'name': "Not Provided",
      'surname': "Not Provided",
      'phone': "Not Provided",
      'email': "Not Provided"
    };
    notifyListeners();
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      _userData = await ProfileBackend().getUserData(userId);
    } catch (e) {
      print("Error fetching user data in AuthProvider: $e");
    }
  }

  void updateUserData(String key, String value) {
    _userData[key] = value;
    notifyListeners();
  }
}

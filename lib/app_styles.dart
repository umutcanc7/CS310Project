import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF1C2641);

  static AppBar buildAppBar({
    required String title,
    required BuildContext context,
    bool showBackButton = true,
  }) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 5,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
} 
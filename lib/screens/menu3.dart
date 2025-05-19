import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';

class Menu3Screen extends StatelessWidget {
  const Menu3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "Menu",
        context: context,
        showBackButton: true,
      ),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/Home");
              break;
            case 1:
              Navigator.pushNamed(context, "/Search");
              break;
            case 2:
              Navigator.pushNamed(context, "/Fortune");
              break;
            case 3:
              Navigator.pushNamed(context, "/Profile");
              break;
          }
        },
      ),
    );
  }
}

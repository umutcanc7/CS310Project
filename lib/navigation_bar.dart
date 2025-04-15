import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndexx;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndexx,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndexx,
      onTap: onTap,
      backgroundColor: const Color.fromARGB(255, 37, 57, 170), 
      type: BottomNavigationBarType.fixed, 
      selectedItemColor: Colors.white, 
      unselectedItemColor: Colors.white, 
      selectedIconTheme: const IconThemeData(size: 24),
      unselectedIconTheme: const IconThemeData(size: 24),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: "Fortune",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

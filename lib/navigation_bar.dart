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
      currentIndex: currentIndexx, // You can manage this with state
      onTap: onTap,
      selectedItemColor: const Color.fromARGB(255, 4, 30, 51),
      unselectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: Colors.white
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromARGB(255, 37, 57, 170),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor:  Color.fromARGB(255, 37, 57, 170),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: "Fortune",
          backgroundColor:  Color.fromARGB(255, 37, 57, 170),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          backgroundColor:  Color.fromARGB(255, 37, 57, 170),
        )
      ],
    );
  }
}

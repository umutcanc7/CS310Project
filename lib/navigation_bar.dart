import 'package:flutter/material.dart';
import 'selected_restaurant.dart';

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
      onTap: (index) {
        if (index == 1) {
          // Search tab
          if (SelectedRestaurant.name == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please pick a restaurant.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (SelectedRestaurant.name != 'piazza') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This restaurant is not yet added to the app. Please pick a restaurant that is added.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            onTap(index);
          }
        } else {
          onTap(index);
        }
      },
      backgroundColor: const Color(0xFF1C2641), 
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

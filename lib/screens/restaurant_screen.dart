import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../selected_restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "Restaurants",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildRestaurantCard(
              context,
              'assets/kucukev.jpg',
              '/Menu1',
            ),
            buildRestaurantCard(
              context,
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSNPoPEQYuCCsh5lFK_WywGmgnZsWKSx9W3A&s',
              '/Menu2',
            ),
            buildRestaurantCard(
              context,
              'assets/kopuklu.jpg',
              '/Menu3',
            ),
            buildRestaurantCard(
              context,
              'assets/piazza.jpg',
              '/Menu',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/Home');
              break;
            case 1:
              Navigator.pushNamed(context, '/Search');
              break;
            case 2:
              Navigator.pushNamed(context, '/Fortune');
              break;
            case 3:
              Navigator.pushNamed(context, '/Profile');
              break;
          }
        },
      ),
    );
  }

  Widget buildRestaurantCard(BuildContext context, String imagePath, String routeName) {
    String restaurantName = '';
    if (routeName == '/Menu1') restaurantName = 'kucukev';
    else if (routeName == '/Menu2') restaurantName = 'other';
    else if (routeName == '/Menu3') restaurantName = 'kopuklu';
    else if (routeName == '/Menu') restaurantName = 'piazza';
    return ElevatedButton(
      onPressed: () {
        SelectedRestaurant.name = restaurantName;
        Navigator.pushNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1C2641), width: 2),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: imagePath.startsWith('http')
              ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';

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
              'https://scontent.fsaw1-14.fna.fbcdn.net/v/t39.30808-6/348269659_1862302194151632_6051998388861171833_n.png?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=A1AXjzfWY9EQ7kNvwF1nfA8&_nc_oc=Adna80dRsrq-fTyGhgVU58jFEaZXMDRE5iHTeVfBIUlJEN41DsQllmuqLbavLuCckq4&_nc_zt=23&_nc_ht=scontent.fsaw1-14.fna&_nc_gid=QegW7_dRgahPIqHu9A7-RQ&oh=00_AfFhkuozUvUxBvBty3wpcR9sFQShgAoP-O-DwWnU6wAJ3w&oe=6809CB65',
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
    return ElevatedButton(
      onPressed: () {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: imagePath.startsWith('http')
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
      ),
    );
  }
}
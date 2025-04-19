import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedCategory = 1; // 0: Food, 1: Drinks, 2: Food(Menu)

  final List<Map<String, dynamic>> drinks = [
    {"name": "Sprite", "price": 30, "isFavorite": false},
    {"name": "Water", "price": 15, "isFavorite": false},
    {"name": "Tea", "price": 15, "isFavorite": false},
    {"name": "Cola Zero", "price": 30, "isFavorite": false},
    {"name": "Fanta", "price": 30, "isFavorite": false},
    {"name": "Coke", "price": 30, "isFavorite": false},
    {"name": "Ayran", "price": 30, "isFavorite": false},
    {"name": "Orange Juice", "price": 80, "isFavorite": false},
    {"name": "Ice Tea", "price": 30, "isFavorite": false},
  ];

  final List<Map<String, dynamic>> foodMenu = [
    {"name": "Schnitzel", "price": 120, "isFavorite": false},
    {"name": "Honey Mustard Schnitzel", "price": 130, "isFavorite": false},
    {"name": "Grilled Chicken Fillet", "price": 125, "isFavorite": false},
    {"name": "Mushroom Schnitzel", "price": 135, "isFavorite": false},
    {"name": "Chili Schnitzel", "price": 135, "isFavorite": false},
  ];

  final List<Map<String, dynamic>> foods = [
    {"name": "Meat Quesadilla", "price": 110, "isFavorite": false},
    {"name": "Chicken Quesadilla", "price": 100, "isFavorite": false},
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1C2641),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppStyles.buildAppBar(
          title: "Menu",
          context: context,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCategoryButton("Food", 0),
                const SizedBox(width: 10),
                buildCategoryButton("Drinks", 1),
                const SizedBox(width: 10),
                buildCategoryButton("Food (Menu)", 2),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: getSelectedMenu(),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/Sepet");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Go To Your Cart!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndexx: 1, // ← you can change this based on the screen index
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
      ),
    );
  }

  Widget buildCategoryButton(String title, int index) {
    bool isSelected = selectedCategory == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF1C2641) : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(title),
    );
  }

  Widget getSelectedMenu() {
    List<Map<String, dynamic>> selectedList;
    if (selectedCategory == 0) {
      selectedList = foods;
    } else if (selectedCategory == 1) {
      selectedList = drinks;
    } else {
      selectedList = foodMenu;
    }

    return ListView.builder(
      itemCount: selectedList.length,
      itemBuilder: (context, index) {
        final item = selectedList[index];
        final bool isFavorite = item["isFavorite"] ?? false;
        final bool inCart = CartService().cartItems.any((cartItem) => cartItem["name"] == item["name"]);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  item["name"],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedList[index]["isFavorite"] = !isFavorite;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${item["price"]}₺",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      if (inCart) {
                        CartService().removeFromCart(item["name"]);
                      } else {
                        CartService().addToCart(item);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
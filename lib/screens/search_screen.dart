import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> results = [];
  final List<Map<String, dynamic>> drinks = [
    {"name": "Sprite", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Water", "price": 15, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Tea", "price": 15, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Cola Zero", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Fanta", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Coke", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Ayran", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Orange Juice", "price": 80, "type": "drink", "isFavorite": false, "inCart": false},
    {"name": "Ice Tea", "price": 30, "type": "drink", "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foodMenu = [
    {"name": "Schnitzel", "price": 120, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Honey Mustard Schnitzel", "price": 130, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Grilled Chicken Fillet", "price": 125, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Mushroom Schnitzel", "price": 135, "type": "menu", "isFavorite": false, "inCart": false},
    {"name": "Chili Schnitzel", "price": 135, "type": "menu", "isFavorite": false, "inCart": false},
  ];

  final List<Map<String, dynamic>> foods = [
    {"name": "Meat Quesadilla", "price": 110, "type": "food", "isFavorite": false, "inCart": false},
    {"name": "Chicken Quesadilla", "price": 100, "type": "food", "isFavorite": false, "inCart": false},
  ];

  @override
  void initState() {
    super.initState();
    final allItems = [...drinks, ...foodMenu, ...foods];
    results = allItems;
  }

  void updateSearch(String query) {
    final search = query.toLowerCase();
    final allItems = [...drinks, ...foodMenu, ...foods];
    setState(() {
      if (search.isEmpty) {
        results = allItems;
      } else {
        results = allItems
            .where((item) => item["name"].toString().toLowerCase().contains(search))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "Search",
        context: context,
        showBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: "Search for drinks, foods, or menus...",
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final bool isFavorite = item["isFavorite"] ?? false;
                final bool inCart = CartService().cartItems.any((cartItem) => cartItem["name"] == item["name"]);

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item["name"], style: const TextStyle(fontSize: 16)),
                            Text("${item["price"]}₺", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            item["isFavorite"] = !isFavorite;
                          });
                        },
                      ),
                      IconButton(
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${item["name"]} added to cart"),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'View Cart',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Sepet');
                                    },
                                  ),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndexx: 1, // 1 = Search tab
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
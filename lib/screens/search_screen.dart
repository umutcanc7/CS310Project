import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';
import '../services/product_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> results = [];
  List<Map<String, dynamic>> allItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductsFromFirestore();
  }

  Future<void> fetchProductsFromFirestore() async {
    setState(() {
      isLoading = true;
    });
    final products = await ProductService().fetchProducts();
    setState(() {
      allItems = products;
      results = products;
      isLoading = false;
    });
  }

  void updateSearch(String query) {
    final search = query.toLowerCase();
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
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
                                inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                if (inCart) {
                                  setState(() {
                                    CartService().removeFromCart(item["name"]);
                                  });
                                } else {
                                  // Check stock before adding
                                  final productService = ProductService();
                                  final products = await productService.fetchProducts();
                                  final dbProduct = products.firstWhere(
                                    (p) => p["name"] == item["name"],
                                    orElse: () => <String, dynamic>{},
                                  );
                                  final stock = dbProduct["stock"] ?? 0;
                                  if (stock > 0) {
                                    setState(() {
                                      CartService().addToCart(item);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Added to your cart!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("This product is out of stock!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
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
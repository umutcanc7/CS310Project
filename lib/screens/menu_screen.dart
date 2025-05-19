import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';
import '../services/product_service.dart';
import '../services/favourites_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  bool isLoading = true;
  String selectedCategory = 'foods'; // Default category

  @override
  void initState() {
    super.initState();
    fetchProductsFromFirestore();
  }

  Future<void> fetchProductsFromFirestore() async {
    setState(() {
      isLoading = true;
    });
    final fetchedProducts = await ProductService().fetchProducts();
    setState(() {
      products = fetchedProducts;
      filterProductsByCategory(selectedCategory);
      isLoading = false;
    });
  }

  void filterProductsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filteredProducts = products.where((product) =>
        (product['category']?.toString().toLowerCase().trim() ?? '') ==
        category.toLowerCase().trim()
      ).toList();
    });
  }

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
          showBackButton: true,
        ),
        body: Column(
          children: [
            // Category Buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('foods', 'Foods'),
                  _buildCategoryButton('drinks', 'Drinks'),
                  _buildCategoryButton('desserts', 'Desserts'),
                ],
              ),
            ),
            // Products List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final item = filteredProducts[index];
                        final bool inCart = CartService().cartItems.any((cartItem) => cartItem["name"] == item["name"]);
                        final String category = item["category"]?.toString().toLowerCase().trim() ?? '';
                        return FutureBuilder<bool>(
                          future: FavouritesService().isFavourite(item["name"], category),
                          builder: (context, snapshot) {
                            final isFavourite = snapshot.data ?? false;
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
                                    flex: 2,
                                    child: Text(
                                      "${item["price"]}₺",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            isFavourite ? Icons.star : Icons.star_border,
                                            color: isFavourite ? Colors.amber : Colors.grey,
                                          ),
                                          onPressed: () async {
                                            if (isFavourite) {
                                              // Remove from favourites
                                              final favs = await FavouritesService().fetchFavourites();
                                              final fav = favs.firstWhere(
                                                (f) => f['name'] == item['name'] && f['category'] == category,
                                                orElse: () => {},
                                              );
                                              if (fav['docId'] != null) {
                                                await FavouritesService().removeFavourite(fav['docId']);
                                                setState(() {});
                                              }
                                            } else {
                                              // Add to favourites
                                              await FavouritesService().addFavourite(
                                                name: item['name'],
                                                category: category,
                                              );
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
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
                                              SnackBar(
                                                content: const Text("Added to your cart!"),
                                                duration: const Duration(seconds: 2),
                                                action: SnackBarAction(
                                                  label: 'Go to Cart',
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/Sepet');
                                                  },
                                                ),
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
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
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

  Widget _buildCategoryButton(String category, String label) {
    final isSelected = selectedCategory == category;
    return ElevatedButton(
      onPressed: () => filterProductsByCategory(category),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.purple : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: isSelected ? 2 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.purple : Colors.grey.shade300,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
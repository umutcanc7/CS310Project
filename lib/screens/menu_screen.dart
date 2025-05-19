import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';
import '../services/product_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> products = [];
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
    final fetchedProducts = await ProductService().fetchProducts();
    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  int selectedCategory = 0; // 0: All

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
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
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
                          flex: 2,
                          child: Text(
                            "${item["price"]}₺",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox.shrink(),
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
}
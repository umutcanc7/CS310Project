import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../app_styles.dart';
import '../cart_service.dart';
import '../services/product_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _noCutlery = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService().cartItems;
    final totalAmount = CartService().totalAmount;

    return Scaffold(
      appBar: AppStyles.buildAppBar(
        title: "YOUR CART",
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Please proceed with the payment',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      'Here is your order!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (cartItems.isEmpty)
                      const Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    else
                      ...cartItems.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item["name"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      CartService().decreaseQuantity(item["name"]);
                                    });
                                  },
                                ),
                                Text(
                                  '${item["quantity"] ?? 1}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () async {
                                    // Check stock before increasing
                                    final productService = ProductService();
                                    final products = await productService.fetchProducts();
                                    final dbProduct = products.firstWhere(
                                      (p) => p["name"] == item["name"],
                                      orElse: () => <String, dynamic>{},
                                    );
                                    final stock = dbProduct["stock"] ?? 0;
                                    final currentQty = item["quantity"] ?? 1;
                                    if (currentQty < stock) {
                                      setState(() {
                                        CartService().increaseQuantity(item["name"]);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Not enough stock available!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${(item["price"] * (item["quantity"] ?? 1)).toStringAsFixed(1)}₺',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  CartService().removeFromCart(item["name"]);
                                });
                              },
                            ),
                          ],
                        ),
                      )).toList(),
                    if (cartItems.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${totalAmount.toStringAsFixed(1)}₺',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          hintText: 'Add a note:',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "I don't want plastic cutlery",
                            style: TextStyle(fontSize: 16),
                          ),
                          Switch(
                            value: _noCutlery,
                            onChanged: (value) {
                              setState(() {
                                _noCutlery = value;
                              });
                            },
                            activeColor: const Color(0xFF1C2641),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartItems.isEmpty ? null : () {
                  Navigator.pushNamed(
                    context,
                    '/DeliveryInfo',
                    arguments: {
                      'notes': _noteController.text,
                      'noCutlery': _noCutlery,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
}
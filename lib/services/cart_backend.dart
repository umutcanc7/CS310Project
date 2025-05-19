import 'package:cloud_firestore/cloud_firestore.dart';

class CartBackend {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('Products');
  final CollectionReference cartsCollection = FirebaseFirestore.instance.collection('Carts');

  // Check if product is in stock before adding to cart
  Future<bool> canAddToCart(String productId) async {
    final doc = await productsCollection.doc(productId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return (data['stock'] ?? 0) > 0;
    }
    return false;
  }

  // Add product to user's cart if in stock and decrease stock
  Future<bool> addToCart({
    required String userId,
    required String productId,
    int quantity = 1,
  }) async {
    final doc = await productsCollection.doc(productId).get();
    if (!doc.exists) return false;
    final data = doc.data() as Map<String, dynamic>;
    final currentStock = (data['stock'] ?? 0) as int;
    if (currentStock < quantity) return false;

    // Add to cart logic (simple: add or update quantity)
    final cartDoc = await cartsCollection.doc(userId).get();
    Map<String, dynamic> cartData = {};
    if (cartDoc.exists) {
      cartData = cartDoc.data() as Map<String, dynamic>;
    }
    final currentQty = (cartData[productId] ?? 0) as int;
    cartData[productId] = currentQty + quantity;
    await cartsCollection.doc(userId).set(cartData);

    // Decrease stock
    await productsCollection.doc(productId).update({'stock': currentStock - quantity});
    return true;
  }
} 
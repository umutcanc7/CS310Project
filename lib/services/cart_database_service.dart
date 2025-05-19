import 'package:cloud_firestore/cloud_firestore.dart';

class CartDatabaseService {
  final CollectionReference cartsCollection = FirebaseFirestore.instance.collection('Carts');

  // Set or update the user's cart
  Future<void> setCart(String userId, List<Map<String, dynamic>> items) async {
    await cartsCollection.doc(userId).set({
      'items': items,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get the user's cart
  Future<List<Map<String, dynamic>>> getCart(String userId) async {
    final doc = await cartsCollection.doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>?;
      if (items != null) {
        return items.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    }
    return [];
  }

  // Clear the user's cart
  Future<void> clearCart(String userId) async {
    await cartsCollection.doc(userId).delete();
  }
} 
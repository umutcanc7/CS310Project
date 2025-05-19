import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('Products');

  // Add a new product
  Future<void> addProduct({
    required String name,
    required double price,
    required int stock,
  }) async {
    await productsCollection.add({
      'name': name,
      'price': price,
      'stock': stock,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update stock for a product by document ID
  Future<void> updateStock(String productId, int newStock) async {
    await productsCollection.doc(productId).update({
      'stock': newStock,
    });
  }

  // Fetch all products
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final querySnapshot = await productsCollection.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,
        'name': data['name'],
        'price': data['price'],
        'stock': data['stock'],
      };
    }).toList();
  }
} 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesService {
  final CollectionReference favouritesCollection = FirebaseFirestore.instance.collection('Favourites');

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> addFavourite({required String name, required String category}) async {
    if (userId == null) return;
    await favouritesCollection.add({
      'userId': userId,
      'name': name,
      'category': category,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFavourite(String docId) async {
    await favouritesCollection.doc(docId).delete();
  }

  Future<List<Map<String, dynamic>>> fetchFavourites() async {
    if (userId == null) return [];
    final querySnapshot = await favouritesCollection.where('userId', isEqualTo: userId).get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'docId': doc.id,
        'name': data['name'],
        'category': data['category'],
      };
    }).toList();
  }

  Future<bool> isFavourite(String name, String category) async {
    if (userId == null) return false;
    final querySnapshot = await favouritesCollection
        .where('userId', isEqualTo: userId)
        .where('name', isEqualTo: name)
        .where('category', isEqualTo: category)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
} 
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference for Users (capitalized as in Firestore)
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  // Add a new user
  Future<String> addUser(String userId, String name, String surname, String email) async {
    try {
      await usersCollection.doc(userId).set({
        'name': name,
        'surname': surname,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User added successfully");
      return "User added successfully";
    } catch (e) {
      print("Error adding user: $e");
      return "Error adding user: $e";
    }
  }
}

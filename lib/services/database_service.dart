import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference for Users (capitalized as in Firestore)
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  // Add a new user with password
  Future<String> addUser(String userId, String name, String surname, String email, String password) async {
    try {
      await usersCollection.doc(userId).set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'phone': '',  // Phone will be added later through profile update
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User added successfully with password");
      return "User added successfully";
    } catch (e) {
      print("Error adding user: $e");
      return "Error adding user: $e";
    }
  }

  // Fetch user data by UID
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print("No user found with UID: $userId");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Update user phone number by UID
  Future<void> updatePhoneNumber(String userId, String phoneNumber) async {
    try {
      await usersCollection.doc(userId).update({
        'phone': phoneNumber,
      });
      print("Phone number updated successfully");
    } catch (e) {
      print("Error updating phone number: $e");
    }
  }
}

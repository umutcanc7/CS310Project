import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileBackend {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  /* ───────────── FETCH ───────────── */
  Future<Map<String, String?>> getUserData(String userId) async {
    try {
      final snap = await usersCollection.doc(userId).get();
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;
        return {
          'email': data['email'] ?? "Not Provided",
          'name': data['name'] ?? "Not Provided",
          'surname': data['surname'] ?? "Not Provided",
          'phone': data['phone'] ?? "Not Provided",
        };
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return {
      'email': "Not Provided",
      'name': "Not Provided",
      'surname': "Not Provided",
      'phone': "Not Provided",
    };
  }

  /* ───────────── GENERIC UPDATE ───────────── */
  Future<void> updateUserData(
    String userId, {
    String? name,
    String? surname,
    String? phone,
  }) async {
    try {
      final Map<String, dynamic> update = {};
      if (name != null) update['name'] = name;
      if (surname != null) update['surname'] = surname;
      if (phone != null) update['phone'] = phone;

      if (update.isNotEmpty) {
        await usersCollection.doc(userId).update(update);
        print("Updated: $update");
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  /* ───────────── LOGOUT CLEANUP ───────────── */
  Future<void> clearUserData(String userId) async {
    try {
      await usersCollection.doc(userId).update({
        'name': "Not Provided",
        'surname': "Not Provided",
        'phone': "Not Provided",
      });
      print("User data cleared for user: $userId");
    } catch (e) {
      print("Error clearing user data: $e");
    }
  }

  /* Convenience Helpers */
  Future<void> updateUserName(String uid, String n) =>
      updateUserData(uid, name: n);
  Future<void> updateUserSurname(String uid, String s) =>
      updateUserData(uid, surname: s);
  Future<void> updateUserPhone(String uid, String p) =>
      updateUserData(uid, phone: p);
}

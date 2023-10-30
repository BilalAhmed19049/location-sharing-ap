import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_sharing_app/Models/firebase_model.dart';

class CreateData {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('locationData');

  Future<void> createUser(FirebaseModel user) async {
    try {
      var doc = dataCollection.doc();
      user.id = doc.id;
      doc.set(user.toMap());
    } catch (error) {
      print('Error creating user: $error');
    }
  }
}

class ReadData {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('locationData');

  Stream<QuerySnapshot> getUsers() {
    return dataCollection.snapshots();
  }
}

class UpdateData {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('locationData');

  Future<void> updateUser(String docId, FirebaseModel user) async {
    try {
      await userCollection.doc(docId).update(user.toMap());
    } catch (error) {
      print('Error Updating user: $error');
    }
  }
}

class DeleteData {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('locationData');

  Future<void> deleteUser(String docId) async {
    try {
      await userCollection.doc(docId).delete();
    } catch (error) {
      print('Error deleting user:$error');
    }
  }
}

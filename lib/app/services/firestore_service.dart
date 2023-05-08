import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseFirestore get dbFirestore => _db;

  Future<void> update(
      String collectionName, String documentName, Map<String, dynamic> data) {
    return _db.collection(collectionName).doc(documentName).update(data);
  }

  Future<void> delete(String collectionName, String documentName) {
    return _db.collection(collectionName).doc(documentName).delete();
  }

  Future<void> insert({
      required String collectionName, String? documentName, required Map<String, dynamic> data}) {
    return _db.collection(collectionName).doc(documentName).set(data);
  }
}

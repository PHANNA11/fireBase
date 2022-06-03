import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/staff_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  static final FireStoreService _firestoreService = _firestoreService;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FireStoreService.internal();

  factory FireStoreService() {
    return _firestoreService;
  }
  Stream<List<Staff>> getNotes() {
    return _db.collection('staff').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Staff.fromMap(doc.data()),
              )
              .toList(),
        );
  }
}

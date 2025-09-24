import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _storage;

  // User operations
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Firestore operations
  CollectionReference get usersCollection => _firestore.collection('users');
  CollectionReference get chatsCollection => _firestore.collection('chats');

  // Storage operations
  Reference get storageRef => _storage.ref();
}

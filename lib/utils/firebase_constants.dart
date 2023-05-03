import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final currentUser = firebaseAuth.currentUser;

final CollectionReference booksRef = firestore.collection('books');
final CollectionReference usersRef = firestore.collection('users');
final CollectionReference reviewsRef = firestore.collection('reviews');
final CollectionReference chatRef = firestore.collection('chat');

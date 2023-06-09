import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// final currentUser = firebaseAuth.currentUser;

final CollectionReference booksRef = firestore.collection('books');
final CollectionReference moviesRef = firestore.collection('movies');
final CollectionReference usersRef = firestore.collection('users');
final CollectionReference reviewsRef = firestore.collection('reviews');
final CollectionReference favoritesRef =
    usersRef.doc(firebaseAuth.currentUser!.uid).collection("favorites");
final CollectionReference chatRef = firestore.collection('chat');
final CollectionReference readingGoalsRef =
    usersRef.doc(firebaseAuth.currentUser!.uid).collection('readingGoals');
final CollectionReference watchingGoalsRef =
    usersRef.doc(firebaseAuth.currentUser!.uid).collection('watchingGoals');
final CollectionReference reportsRef = firestore.collection('reports');

final storageRef = FirebaseStorage.instance.ref();

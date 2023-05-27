import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final currentUser = firebaseAuth.currentUser;

final CollectionReference booksRef = firestore.collection('books');
final CollectionReference moviesRef = firestore.collection('movies');
final CollectionReference usersRef = firestore.collection('users');
final CollectionReference reviewsRef = firestore.collection('reviews');
final CollectionReference favoritesRef =
    usersRef.doc(currentUser!.uid).collection("favorites");
final CollectionReference chatRef = firestore.collection('chat');
final CollectionReference readingGoalsRef =
    usersRef.doc(currentUser!.uid).collection('readingGoals');
final CollectionReference watchingGoalsRef =
    usersRef.doc(currentUser!.uid).collection('watchingGoals');

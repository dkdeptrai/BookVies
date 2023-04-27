import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

final CollectionReference booksRef = firestore.collection('Book1');

// import 'package:bookvies/firebase_options.dart';
// import 'package:bookvies/models/book_model.dart';
// import 'package:bookvies/services/book_service.dart';
// import 'package:bookvies/utils/firebase_constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// // import 'package:mocktail/mocktail.dart';
//
// // class MockFirestore extends Mock implements FirebaseFirestore {}
//
// class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
//
// class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
//
// class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
//
// class MockBookService extends Mock implements BookService {}
//
// void main() {
//   late FakeFirebaseFirestore firestore;
//   late MockDocumentSnapshot mockDocumentSnapshot;
//   late MockCollectionReference mockCollectionReference;
//   late MockDocumentReference mockDocumentReference;
//
//   group('BookService', () {
//     late MockBookService mockBookService;
//
//     setUp(() async {
//       // TestWidgetsFlutterBinding.ensureInitialized();
//       // await Firebase.initializeApp();
//       // firestore = FakeFirebaseFirestore();
//       // mockCollectionReference = MockCollectionReference();
//       // mockDocumentReference = MockDocumentReference();
//       // mockDocumentSnapshot = MockDocumentSnapshot();
//     });
//
//     test('getPopularBooks', () async {
//       final firestore = FakeFirebaseFirestore();
//       final collection = firestore.collection('test');
//       collection.add({'foo': 'bar'});
//       collection.add({'foo': 'bar'});
//       collection.add({'foo': 'bar'});
//       // final doc = collection.doc('test');
//       // await doc.set({
//       //   'nested': {'field': 3}
//       // });
//       //
//       // final snapshot = await doc.get();
//       final snapshot = await collection.get();
//       when(() => firestore.collection("books")).thenAnswer((_) => collection);
//       // when(collection.orderBy(anyNamed("averageRating")).limit(anyNamed("limit")).get()).thenAnswer((_) async => snapshot);
//
//       // expect(() => collection.get(), throwsA(isA<StateError>()));
//       expect(snapshot.docs.length, greaterThan(0));
//       final bookService = BookService(booksRef: collection);
//       final books = await bookService.getPopularBooks(limit: 2);
//       expect(books.length, 2);
//       //
//       // when(() => firestore.collection("books")).thenReturn(mockCollectionReference);
//       // when(() => mockCollectionReference.doc(any())).thenReturn(mockDocumentReference);
//       // when(() => mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
//       // when(() => mockDocumentSnapshot.data()).thenReturn({
//       //   "id": "1",
//       //   "name": "name",
//       //   "description": "description",
//       //   "image": "image",
//       //   "reviews": [],
//       //   "numberReviews": 0,
//       //   "averageRating": 0,
//       //   "author": "author",
//       //   "publisher": "publisher",
//       //   "isbn": "isbn",
//       //   "firstPublishDate": DateTime.now(),
//       //   "pages": 123,
//       //   "genres": ["Honor"],
//       // });
//       //
//       // final result = await BookService().getPopularBooks(limit: 2);
//       // print(result);
//
//       // Mock the behavior of the Firestore call
//       // when(() => mockBookService.getPopularBooks(limit: any(named: "limit"))).thenAnswer((_) async {
//       //   // Mock data to return
//       //   return [
//       //     Book(
//       //       id: "1",
//       //       name: "name",
//       //       description: "description",
//       //       image: "image",
//       //       reviews: [],
//       //       numberReviews: 0,
//       //       averageRating: 0,
//       //       author: "author",
//       //       publisher: "publisher",
//       //       isbn: "isbn",
//       //       firstPublishDate: DateTime.now(),
//       //       pages: 123,
//       //       genres: ["Honor"],
//       //     ),
//       //     Book(
//       //       id: "1",
//       //       name: "name",
//       //       description: "description",
//       //       image: "image",
//       //       reviews: [],
//       //       numberReviews: 0,
//       //       averageRating: 0,
//       //       author: "author",
//       //       publisher: "publisher",
//       //       isbn: "isbn",
//       //       firstPublishDate: DateTime.now(),
//       //       pages: 123,
//       //       genres: ["Honor"],
//       //     ),
//       //
//       //     // Add more mock books as needed
//       //   ];
//       // });
//
//       // // Call the mocked function
//       // final popularBooks = await mockBookService.getPopularBooks(limit: 2);
//       //
//       // // Verify that the function was called with the correct arguments
//       // verify(() => mockBookService.getPopularBooks(limit: 2)).called(1);
//       //
//       // // Your assertions based on the expected result
//       // expect(popularBooks.length, 2);
//       // Add more assertions based on your expected data
//     });
//   });
// }
//
// // void main() {
// //   group('BookServiceTest -', () {
// //     final bookService = BookService();
// //
// //     test('getPopularBooks returns top rated books', () async {
// //       // Mock Firestore classes
// //       final mockFirestore = MockFirestore();
// //       final mockQuery = MockFirestoreQuery();
// //       final mockDoc1 = MockDocumentSnapshot();
// //       final mockDoc2 = MockDocumentSnapshot();
// //
// //       // Set up mock data and behavior
// //       when(mockFirestore.collection("books")).thenReturn(mockQuery);
// //       when(mockQuery.orderBy('averageRating', descending: true)).thenReturn(mockQuery);
// //       when(mockQuery.limit(10)).thenReturn(mockQuery);
// //       when(mockQuery.get()).thenAnswer((_) => Future.value(QuerySnapshot<Object>(docs: [mockDoc1, mockDoc2])));
// //       when(mockDoc1.data()).thenReturn(
// //       Book(
// //         id: "1",
// //         name: "name",
// //         description: "description",
// //         image: "image",
// //         reviews: [],
// //         numberReviews: 0,
// //         averageRating: 0,
// //         author: "author",
// //         publisher: "publisher",
// //         isbn: "isbn",
// //         firstPublishDate: DateTime.now(),
// //         pages: 123,
// //         genres: ["Honor"],
// //       )
// //       );
// //       when(mockDoc2.data()).thenReturn(Book(
// //         id: "1",
// //         name: "name",
// //         description: "description",
// //         image: "image",
// //         reviews: [],
// //         numberReviews: 0,
// //         averageRating: 0,
// //         author: "author",
// //         publisher: "publisher",
// //         isbn: "isbn",
// //         firstPublishDate: DateTime.now(),
// //         pages: 123,
// //         genres: ["Honor"],
// //       ));
// //
// //       // Inject mock Firestore into service
// //       final bookService = BookService();
// //
// //       // Call the function and verify results
// //       final popularBooks = await bookService.getPopularBooks(limit: 2);
// //       expect(popularBooks.length, 2);
// //       // expect(popularBooks[0].averageRating, 4.5);
// //       // expect(popularBooks[1].averageRating, 4.0);
// //     });
// //   });
// // }
// //

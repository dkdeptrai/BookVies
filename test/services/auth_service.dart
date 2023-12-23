import 'package:bookvies/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart';

import 'auth_service.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements Future<UserCredential> {}

typedef Callback = void Function(MethodCall call);

@GenerateNiceMocks([
  // MockSpec<FirebaseAuth>(as: #MockFirebaseAuth),
  MockSpec<UserCredential>(as: #MockUserCredential),
])
void main() {
  // setUpAll(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // });

  group("AuthenticationService", () {
    test('logIn returns authenticated user on successful login', () async {
      // AutomatedTestWidgetsFlutterBinding.ensureInitialized();
      // TestWidgetsFlutterBinding.ensureInitialized();
      // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      final mockFirebaseAuth = MockFirebaseAuth();
      final mockUserCredential = MockUserCredential();
      final authService = AuthenticationService(firebaseAuth: mockFirebaseAuth);

      // Mock successful signInWithEmailAndPassword call
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "email",
        password: "password",
      )).thenAnswer((_) async {
        return Future.value(mockUserCredential);
      });

      // Mock currentUser call after successful login
      // when(mockFirebaseAuth.currentUser).thenReturn(mockUserCredential.user);
      print("1");
      // Call the logIn method
      final result = await authService.logIn(email: 'nguyentienvi19072003@gmail.com', password: 'Vi123456');
      print(2);

      // Verify that the signInWithEmailAndPassword method was called with the correct arguments
      // verify(mockFirebaseAuth.signInWithEmailAndPassword(
      //   email: 'nguyentienvi19072003@gmail.com',
      //   password: 'Vi123456',
      // )).called(1);

      // Verify that the currentUser method was called after successful login
      // verify(mockFirebaseAuth.currentUser).called(1);

      // Verify that the result is not null and is an instance of AuthUser
      // expect(result, isNotNull);
      // expect(result, isA<AuthUser>());
    });
  });
}

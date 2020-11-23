import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class CustomMockFirebaseAuth extends Mock implements FirebaseAuth {
  
  CustomMockFirebaseAuth() {
    when(this.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password'))).thenAnswer((_) async => Future.value(MockUserCredential()));
  }
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User get user => MockUser();
}

class MockUser extends Mock implements User {
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebaseFirestore instance;
  FirebaseAuth auth;


  setUp(() async {
    instance = MockFirestoreInstance();
    Firebase.initializeApp();
    UserService.auth = FirebaseAuth.instance;

    /*instance = MockFirebaseAuth();
    MarkerService.database = instance;
    auth = FirebaseAuth.instance;
    Firebase.initializeApp()*/
  });


  test('un usuario puede loguearse', () async {
    User localUser;

    UserService.login("barry.allen@example.com", "SuperSecretPassword!");

    UserService.auth.authStateChanges().listen((User user) {
      localUser = user;
    });

    assert(localUser != null);
  });
}
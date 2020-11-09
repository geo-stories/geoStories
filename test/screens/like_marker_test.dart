import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/screens/welcome_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:like_button/like_button.dart';

void main() {
  Widget widget = MaterialApp(
    home: WelcomePage(),
  );



  FirebaseFirestore instance;
  FirebaseAuth auth;

  setUp(() async {
    instance = MockFirestoreInstance();
    MarkerService.database = instance;
    auth = MockFirebaseAuth();
    UserService.auth = auth;
  });


  testWidgets('Usuario registrado like se persiste', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes' : [],
    });


    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");
    await tester.tap(find.byType(RoundedButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    final snapshot = await instance.collection('markers').get();


    expect(snapshot.docs.first.data()['likes'].toString() != "[]",true);
  });

  testWidgets('Usuario registrado like se persiste', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes' : [],
    });


    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");
    await tester.tap(find.byType(RoundedButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    final snapshot = await instance.collection('markers').get();


    expect(snapshot.docs.first.data()['likes'].toString() != "[]",true);
  });





}

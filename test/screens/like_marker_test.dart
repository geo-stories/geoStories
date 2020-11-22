import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/dataHelper/MarkerDataHelper.dart';
import 'package:geo_stories/dataHelper/UserDataHelper.dart';
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
    auth = MockFirebaseAuth(signedIn: true);
    UserService.auth = auth;
  });


  testWidgets('Cuando un usuario que inicio sesion da like, se logra persistir en la base de datos', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

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


  testWidgets('Usuario Anon da like y no pasa nada', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Ingresar como Anon")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final snapshot = await instance.collection('markers').get();
    expect(snapshot.docs.first.data()['likes'].toString() == "[]",true);
  });


  testWidgets('Usuario registrado da like y lo saca y y modifica firebase', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

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

    //da like
    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    //saca el like
    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final snapshot = await instance.collection('markers').get();
    expect(snapshot.docs.first.data()['likes'].toString() == "[]",true);
  });
}
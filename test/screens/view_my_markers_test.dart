import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:geo_stories/dataHelper/MarkerDataHelper.dart';
import 'package:geo_stories/dataHelper/UserDataHelper.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/screens/welcome_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';

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


  testWidgets('Dado un usuario que inicia sesión, al ver sus marcadores '
      'selecciona el primero en la lista', (WidgetTester tester) async {
    //Tiene solo un marcador
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

    // WelcomePage, Login
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    // MapPage
    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey("MisMarcadores")));
    await tester.pumpAndSettle();
    await tester.pumpWidget(widget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final map = find.byType(MapPage);
    expect(map, findsOneWidget);
  });


  testWidgets('Dado un usuario que inicia sesión (sin marcadores) al ver sus marcadores '
      'Aclara que no tiene marcadores', (WidgetTester tester) async {

    // WelcomePage, Login
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");

    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    // MapPage
    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey("MisMarcadores")));
    await tester.pumpAndSettle();
    await tester.pumpWidget(widget);

    expect(find.text('No tiene ningun marcador.'), findsOneWidget);
  });

}
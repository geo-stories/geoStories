import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/screens/signup_page.dart';
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
    auth = MockFirebaseAuth();
    UserService.auth = auth;
  });


  testWidgets('Dado un usuario anonimo, al abrir el drawer acciona sobre registrarse'
      ' y se dirige a la pagina registrarse', (WidgetTester tester) async {

    // WelcomePage
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // Inicia como anonimo
    await tester.tap(find.byKey(ValueKey("Ingresar como Anon")));
    await tester.pumpAndSettle();

    // MapPage - Drawer
    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();

    // Acciona sobre el registrarse
    await tester.tap(find.byKey(ValueKey("Register")));
    await tester.pumpAndSettle();

    // Se redirige a la pagina de registro
    final signUpPage = find.byType(SignUpPage);
    expect(signUpPage, findsOneWidget);
  });


  testWidgets('Dado un usuario anonimo, al abrir el drawer acciona sobre Cerrar sesion, '
      'se desconecta de su sesion y se redirige a la welcomePage', (WidgetTester tester) async {

    // WelcomePage
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // Pantalla Login
    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    // Carga los datos del usuario para iniciar sesion
    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");

    // Inicia sesion
    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpAndSettle();

    // MapPage - Drawer
    await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();

    // Acciona sobre Cerrar sesion
    await tester.tap(find.byKey(ValueKey("Logout")));
    await tester.pumpAndSettle();

    // Se redirige a la WelcomePage
    final welcomePage = find.byType(WelcomePage);
    expect(welcomePage, findsOneWidget);
  });

}
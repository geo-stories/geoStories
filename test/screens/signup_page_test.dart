import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/screens/signup_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:mockito/mockito.dart';

import '../util/mock_firebase_auth.dart';

void main() {
  Widget widget = MaterialApp(
    home: SignUpPage(),
  );

  FirebaseFirestore instance;
  FirebaseAuth authInstance;

  setUp(() async {
    instance = MockFirestoreInstance();
    authInstance = CustomMockFirebaseAuth();
    UserService.database = instance;
    MarkerService.database = instance;
    UserService.auth = authInstance;
  });


  testWidgets('una persona no puede registrarse si los cuatro campos están vacios', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-campos-sin-completar')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si alguno de los cuatro campos está vacio', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holi');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-campos-sin-completar')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si el nombre de usuario es muy largo', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'holi');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-nombre-usuario-muy-largo')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si la contraseña es muy corta', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'holi');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-contraseña-muy-corta')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si las contraseñas no coinciden', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'chau');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-contraseñas-no-coinciden')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si el email no conforma las reglas de firebase', (WidgetTester tester) async {
    when(authInstance.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(FirebaseAuthException(code: 'invalid-email', message: 'Email Inválido'));

    await tester.pumpWidget(widget);
    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-error-firebase')), findsOneWidget);
  });

  testWidgets('una persona no puede registrarse si firebase rompe inesperadamente', (WidgetTester tester) async {
    when(authInstance.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(FirebaseAuthException(code: 'error-inesperado', message: 'Error Inesperado'));

    await tester.pumpWidget(widget);
    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('snackbar-error-firebase')), findsOneWidget);
  });

  testWidgets('una persona puede registrarse y es redirigida a MapPage', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byKey(Key('input-registro-nombre-usuario')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-email')), 'holi');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('input-registro-repetir-contraseña')), 'holiii');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('boton-registrarse')));
    await tester.pumpAndSettle();

    expect(find.byType(MapPage), findsOneWidget);
  });
}
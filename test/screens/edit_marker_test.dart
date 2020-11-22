import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/dataHelper/MarkerDataHelper.dart';
import 'package:geo_stories/dataHelper/UserDataHelper.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';

void main() {

  Widget widget = MaterialApp(
    home: MapPage(),
  );

  FirebaseFirestore instance;
  FirebaseAuth auth;

  setUp(() async {
    instance = MockFirestoreInstance();
    MarkerService.database = instance;
    auth = MockFirebaseAuth(signedIn: true);
    UserService.auth = auth;
  });


  testWidgets('Intentar editar un marcador un campo vacío muestra un AlertDialog', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("EditButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("field2")), "");

    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("GuardarButton")));
    await tester.pumpWidget(widget);

    final alertFinder = find.byType(AlertDialog);
    expect(alertFinder, findsOneWidget);
  });


  testWidgets('Al editar un marcador con con todos los campos completos, vuelvo al MapPage', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("EditButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("field2")), "estoy cambiando la descripcion");
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("GuardarButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MapPage), findsOneWidget);
  });


  testWidgets('Cambio el markador en la base de datos', (WidgetTester tester) async {
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelper(instance, auth);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("EditButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final description = "estoy cambiando la descripcion";
    await tester.enterText(find.byKey(ValueKey("field2")), description);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("GuardarButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final query = await instance.collection('markers').get();
    final newDescripcion = (query.docs.first.data()['description']);

    expect(newDescripcion, description);
  });


  testWidgets('cancelo el cambio de la descripcion del marcador y no se me guarda la nueva descripcion', (WidgetTester tester) async {
    final oldDescription = "description";
    await UsuariosMockerDataHelper(instance, auth);
    await MarkersMockerDataHelperWithDescription(instance, oldDescription, auth);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("EditButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final description = "estoy cambiando la descripcion";
    await tester.enterText(find.byKey(ValueKey("field2")), description);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("CancelButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final query = await instance.collection('markers').get();
    final newDescripcion = (query.docs.first.data()['description']);

    expect(newDescripcion, oldDescription);
  });

}
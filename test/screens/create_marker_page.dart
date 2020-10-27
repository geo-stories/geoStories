import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:geo_stories/services/marker_service.dart';

void main() {

  Widget widget = MaterialApp(
    home: MapPage(),
  );

  FirebaseFirestore instance;

  setUp(() {
    instance = MockFirestoreInstance();
    MarkerService.database = instance;
  });

  testWidgets('no deberia poder crear un Marker con campos vacíos', (WidgetTester tester) async {


    expect("?", "?");
  });

  testWidgets('Persistir un marcador creado', (WidgetTester tester) async {

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect("?", "?");
  });
}
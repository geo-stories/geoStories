
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
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


  testWidgets('Intentar editar un marcador un campo vacío muestra un AlertDialog', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
          'latitude': -34.6001014,
          'longitude': -58.3824443,
          'title' : "prueba",
          'description' : "description",
        });
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("EditButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    print(find.byKey(ValueKey("field2")).first);

    await tester.enterText(find.byKey(ValueKey("field2")), "");

    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("GuardarButton")));
    await tester.pumpWidget(widget);

    final alertFinder = find.byType(AlertDialog);
    expect(alertFinder, findsOneWidget);
  });

  testWidgets('Al editar un marcador con con todos los campos completos, vuelvo al MapPage', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
    });
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

    print(find.byType(AlertDialog));

    expect(find.byType(MapPage), findsOneWidget);
  });
}
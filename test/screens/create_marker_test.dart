// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:geo_stories/components/btn_createmarker.dart';
// import 'package:geo_stories/screens/map_page.dart';
// import 'package:geo_stories/services/marker_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/screens/create_marker_page.dart';
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


  testWidgets('Intentar crear un marcador con campos vacíos muestra un AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpWidget(widget);

    await tester.tap(find.byType(FlutterMap));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    await tester.tap(find.byType(RaisedButton));
    await tester.pumpWidget(widget);

    final alertFinder = find.byType(AlertDialog);
    expect(alertFinder, findsOneWidget);
  });

  testWidgets('Al crear un marcador con éxito, vuelvo al MapPage', (WidgetTester tester) async {

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpWidget(widget);

    await tester.tap(find.byType(FlutterMap));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, "Prueba");
    await tester.enterText(find.byType(TextField).last, "Prueba 2");
    
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MapPage),findsOneWidget);
  });
}
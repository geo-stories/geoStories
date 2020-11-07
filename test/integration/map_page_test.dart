import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/marker_service.dart';

void main() {

  Widget widget = MaterialApp(
    home: MapPage(),
  );

  FirebaseFirestore instance;

  setUpAll(() {
    instance = MarkerService.database;
  });

  tearDownAll(() async {
    instance.collection('markers').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  });

  testWidgets('no se muestran Markers si MapPage no tiene marcadores', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MarkerIcon), findsNothing);
  });

  testWidgets('se muestra un Marker por cada marcador de MapPage', (WidgetTester tester) async {
    instance.collection("markers").add({'name': 'nombre', 'description': 'descripcion', 'latitude': -34.6001014, 'longitude': -58.3824443});

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MarkerIcon), findsOneWidget);
  });
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
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
    auth = MockFirebaseAuth();
    UserService.auth = auth;
  });

  /*
  Notas de testing
  1. Siempre testear por la presencia de MarkerIcon, nunca de Marker
  2. Si se va a testear la presencia de un MarkerIcon en el mapa, tener cuidado de que las coordenadas sean cercanas al centro del mapa
     latitud -34.6001014, longitud -58.3824443
   */

  testWidgets('no se muestran Markers si MapPage no tiene marcadores', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MarkerIcon), findsNothing);
  });


  testWidgets('se muestra un Marker por cada marcador de MapPage', (WidgetTester tester) async {
    instance.collection("markers").add({'title': 'nombre', 'description': 'descripcion', 'latitude': -34.6001014, 'longitude': -58.3824443, 'likes' : [], 'owner' : 'Sarasa'});

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(MarkerIcon), findsOneWidget);
  });
}
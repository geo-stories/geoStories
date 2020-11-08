import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/screens/welcome_page.dart';
import 'package:like_button/like_button.dart';

void main() {
  Widget widget = MaterialApp(
    home: WelcomePage(),
  );


  FirebaseFirestore instance;

  setUp(() {
    instance = MockFirestoreInstance();
  });


  testWidgets('Usuario registrado like se persiste', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("Boton iniciar sesion")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(ValueKey("Mail")), "test@geostories.com");
    await tester.enterText(find.byKey(ValueKey("PW")), "UNQpassword");
    await tester.tap(find.byKey(ValueKey("Iniciar Sesion")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();


    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(LikeButton));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byWidget(MapPage()), findsOneWidget);
  });
}

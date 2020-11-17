import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/components/Ui/rounded_textbox_field.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/models/comment_dto.dart';
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
    auth = MockFirebaseAuth();
    UserService.auth = auth;
  });

  testWidgets('cuando intento publicar con un anonimo tira un AlertDialog', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes': [],
      'owner': 'Sarasa',
      'comments' : []
    });

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("CommentsButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final comment = "este es un comentario de prueba";
    await tester.enterText(find.byType(RoundedTextboxField), comment);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("SendComment")));
    await tester.pumpWidget(widget);

    final alertDialog = find.byKey(ValueKey("Por favor, inicie sesión para comentar."));
    expect(alertDialog, findsOneWidget);
  });


  testWidgets('cuando intento publicar algo vacio tira un AlertDialog', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes': [],
      'owner': 'Sarasa',
      'comments' : []
    });
    auth.createUserWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");
    auth.signInWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("CommentsButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final comment = "";
    await tester.enterText(find.byType(RoundedTextboxField), comment);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("SendComment")));
    await tester.pumpWidget(widget);


    final alertFinder = find.byKey(ValueKey("Por favor, ingrese un comentario válido."));
    expect(alertFinder, findsOneWidget);
  });


  testWidgets('cuando envio un comntario se publica', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes': [],
      'owner': 'Sarasa',
      'comments' : []
    });
    auth.createUserWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");
    auth.signInWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("CommentsButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final comment = "este es un comentario de prueba";
    await tester.enterText(find.byType(RoundedTextboxField), comment);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("SendComment")));
    await tester.pumpWidget(widget);


    final query = await instance.collection('markers').get();
    var queryMapResult = query.docs.first.data()['comments'].first;
    CommentDTO commentDTO = CommentDTO.fromJSON(queryMapResult);
    expect(commentDTO.text, comment);
  });


  testWidgets('cuando intento pasarme de caracteres y publicar se publica un comentario recortado', (WidgetTester tester) async {
    await instance.collection('markers')
        .add({
      'latitude': -34.6001014,
      'longitude': -58.3824443,
      'title' : "prueba",
      'description' : "description",
      'likes': [],
      'owner': 'Sarasa',
      'comments' : []
    });
    auth.createUserWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");
    auth.signInWithEmailAndPassword(email: "test@geostories.com",  password: "UNQpassword");

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarkerIcon));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("CommentsButton")));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final comment = "Esto es un comentario con mas de ciento cuarenta caracteres para los tests de firestore. Si este test tiene exito, este comentario se recorta";
    await tester.enterText(find.byType(RoundedTextboxField), comment);
    await tester.pumpWidget(widget);

    await tester.tap(find.byKey(ValueKey("SendComment")));
    await tester.pumpWidget(widget);


    final query = await instance.collection('markers').get();
    var queryMapResult = query.docs.first.data()['comments'].first;
    CommentDTO commentDTO = CommentDTO.fromJSON(queryMapResult);
    final comentarioEsperado = "Esto es un comentario con mas de ciento cuarenta caracteres para los tests de firestore. Si este test tiene exito, este comentario se recort";
    expect(commentDTO.text, comentarioEsperado);
  });
}
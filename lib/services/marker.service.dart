
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;

  static Future<void> createMarker() async {
    await database.collection("marcadores")
          .doc("1")
          .set({
            'titulo': 'Mastering Flutter',
            'descripcion': 'Programming Guide for Dart'
          });

    // DocumentReference ref = await database.collection("marcadores");
    //    .add({
    //  'title': 'Flutter in Action',
    //  'description': 'Complete Programming Guide to learn Flutter'
    // });
  }



}
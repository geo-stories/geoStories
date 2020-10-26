
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;

  static Future<void> createMarker(String  nombre  , String  descripcion) async {
    await database.collection("markers")
          .doc()
          .set({
            'title': nombre,
            'description': descripcion,
            'longitude' : 49,
            'latitude' : 420
          });

    // DocumentReference ref = await database.collection("marcadores");
    //    .add({
    //  'title': 'Flutter in Action',
    //  'description': 'Complete Programming Guide to learn Flutter'
    // });
  }



}
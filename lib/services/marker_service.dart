import 'package:cloud_firestore/cloud_firestore.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;

  static Future<void> createMarker(String title, String description, double latitude, double longitude) async {
    await database.collection("markers")
          .doc("1")
          .set({
            'title': title,
            'description': description,
            'latitude': latitude,
            'longitude': longitude
          });
  }



}
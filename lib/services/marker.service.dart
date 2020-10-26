
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/markerDTO.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;
  static final dto = MarkerDTO();


  static Future<void> createMarker(String  name  , String  description) async {
     Marker newMarker = dto.createMarker(name, description);
     await database.collection("markers")
        .doc()
        .set({
      'name' : name,
      'description' : name,
      /*'heigh' : newMarker.height,
      'width' : newMarker.width,
      'point' : newMarker.point,

       */
     });
  }



}
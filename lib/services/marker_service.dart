import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:latlong/latlong.dart';

class MarkerService {
  static FirebaseFirestore database = FirebaseFirestore.instance;

  static Future<void> createMarker(String name, String description, LatLng point) async {
    try{
        await database.collection("markers")
            .add({
          'latitude': point.latitude,
          'longitude': point.longitude,
          'name' : name,
          'description' : description,
        });
      }
      catch(e){
        print(e);
      }
  }

  static Future<List<MarkerDTO>> getMarkers() async {
    final query = await database.collection("markers").get();
    return query.docs.map((marker) => MarkerDTO.fromJSON(marker.data())).toList();
  }
}
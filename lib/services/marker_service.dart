import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;

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
}
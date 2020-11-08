import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:latlong/latlong.dart';

class MarkerService {
  static FirebaseFirestore database = FirebaseFirestore.instance;


  static Future<void> createMarker(String title, String description, LatLng point) async {
    try{
        await database.collection("markers")
            .add({
          'latitude': point.latitude,
          'longitude': point.longitude,
          'title' : title,
          'description' : description,
        });
      }
      catch(e){
        print(e);
      }
  }
  static updateMarker(String title, String description,MarkerDTO dto){
       database.collection("markers").doc(dto.id).update({
         'title' : title,
         'description' : description,
       });
  }

  
  
  static Stream<QuerySnapshot> getMarkerSnapshots() {
    return database.collection("markers").snapshots();
  }

  static Future<void> refreshLikes(String markerId, String uid, bool isLiked) async {
    if(isLiked){
      removeLike(markerId, uid);
    }else{
      addLike(markerId, uid);
    }
  }

  static Future<void> addLike(String markerId, String uid) async {
    database.collection("markers").doc(markerId).update({
      'likes' : FieldValue.arrayUnion([uid]),
    });
  }

  static Future<void> removeLike(String markerId, String uid) async {
    database.collection("markers").doc(markerId).update({
      'likes' : FieldValue.arrayRemove([uid]),
    });
  }


}

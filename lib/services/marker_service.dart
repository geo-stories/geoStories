import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/services/utils_service.dart';
import 'package:latlong/latlong.dart';

class MarkerService {
  static FirebaseFirestore database = FirebaseFirestore.instance;

  static Future<void> createMarker(String title, String description, LatLng point, String owner) async {
    try{
        await database.collection("markers")
            .add({
          'latitude': point.latitude,
          'longitude': point.longitude,
          'title' : title,
          'description' : description,
          'likes' : [],
          'owner' : owner,
          'comments' : []
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

  static Stream<DocumentSnapshot> getSingleMarkerSnapshots(String markerId) {
    return database.collection("markers").doc(markerId).snapshots();
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

  static Future<void> addComment(String markerId, String uid, String text) async {
    var commentId = UtilsService.generateFirestoreId();
    database.collection("markers").doc(markerId).update({
      'comments' : FieldValue.arrayUnion([{
        'commentId': commentId,
        'userId': uid,
        'text': text
      }]),
    });
  }

  static Future<String> GetOwnerUsername(String markerOwner) async {
    String username = "";
    await database.collection("users").doc(markerOwner).get().then((DocumentSnapshot documentSnapshot) {
      username = documentSnapshot.data()['username'];
    });
    return username;
  }

  static Future<List<dynamic>> GetMarkersDTOByOwner(String owner) async {
    List<dynamic> list;
    QuerySnapshot markers = await database.collection("markers").where("owner", isEqualTo: owner).get();
    list = markers.docs.map((DocumentSnapshot docSnapshot){
      return MarkerDTO.fromJSON(docSnapshot.data());
    }).toList();
    return list;
  }

}

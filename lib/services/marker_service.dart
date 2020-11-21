import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/models/user_dto.dart';
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

  static Stream<UserDTO> GetOwnerUsername(String markerOwner) {
    var result = database.collection("users").doc(markerOwner).get();
    final userDTO = result.asStream().map((document) => UserDTO.fromJSON(document.data()));
    return userDTO;
  }
/*
  List<Marker> _markers(List<QueryDocumentSnapshot> documents) {
    final markerDtos = documents.map((document) => MarkerDTO.fromJSON(document.data(), document.id)).toList();
    final markers = markerDtos.map((markerDto) {
      return Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 50.0,
        height: 50.0,
        point: LatLng(markerDto.latitude , markerDto.longitude),
        builder: (ctx) => MarkerIcon(markerDTO: markerDto,),
      );
    }).toList();
    if (_markerUsuario != null) {
      markers.add(_markerUsuario);
    }
    return markers;
  }
  */
}

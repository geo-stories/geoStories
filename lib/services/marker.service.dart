
import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/markerDTO.dart';
import 'package:latlong/latlong.dart';

class MarkerService {
  static final database = FirebaseFirestore.instance;
  static final dto = MarkerDTO();


  static Future<void> createMarker(String  name  , String  description, LatLng point) async {
    try{
    Marker newMarker = dto.createMarker(name, description,point);

        await database.collection("markers")
            .add({
          'heigh': newMarker.height,
          'width': newMarker.width,
          'name' : newMarker.name,
          'description' : newMarker.description,
          'point':newMarker.point

        });
      }
      catch(e){
        print(e);
      }





  }



}
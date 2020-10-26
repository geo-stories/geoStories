import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerDTO {
  Marker marker = null;
  createMarker (String  name , String description, LatLng point) {
    this.marker =  Marker(
        name: name,
        description: description,
        width: 80.0,
        height: 80.0,
        point: LatLng(point.latitude, point.longitude),
        builder: (ctx) => Icon(
          Icons.location_on,
          color : Colors.red,
          size: 60,
        )
    );
    return marker;
  }
}
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerDTO {
  Marker marker = null;
  createMarker (String  name , String description) {
    this.marker =  Marker(
        name: name,
        description: description,
        width: 80.0,
        height: 80.0,
        point: LatLng(-34.6001014, -58.3824443),
        builder: (ctx) => Icon(
          Icons.location_on,
          color : Colors.red,
          size: 60,
        )
    );
    return marker;
  }
}
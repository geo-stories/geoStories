import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:latlong/latlong.dart';


class MapPage extends StatelessWidget {

  Future<void> createMarker() async {
    await MarkerService.createMarker('Titulo de Marcador', 'Descripcion de Marcador', 60.000, 54.235);
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
        color: Colors.indigo,
        textColor: Colors.white,
        onPressed: () { this.createMarker(); },
        child: Text(
            "BOTON",
            style: TextStyle(
              fontSize: 20.0,
            )));
  }
}
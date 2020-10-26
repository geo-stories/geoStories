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
    return new FlutterMap(
      options: MapOptions(
        minZoom: 2,
        maxZoom: 18,
        center: LatLng(-34.6001014, -58.3824443),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            minZoom: 2,
            maxZoom: 18,
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            // Marcador de ejemplo
            // Se puede borrar una vez hechos los otros tickets
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(-34.6001014, -58.3824443),
              builder: (ctx) => Icon(
                Icons.location_on,
                color: Colors.red,
                size: 60,
              ),
            ),
          ],
        ),
      ],
    );

  }

}
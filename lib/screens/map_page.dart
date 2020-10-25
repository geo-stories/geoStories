import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        maxZoom: 18,
        center: LatLng(-34.6001014, -58.3824443),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
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
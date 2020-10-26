import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/components/btn_createmarker.dart';
import 'package:latlong/latlong.dart';
import 'package:geo_stories/screens/create_marker_page.dart';

class MapPage extends StatefulWidget {

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MarkerPage form;
  bool _modoCreacion = false;

  void _activarModoCreacion() {
    setState(() {
      _modoCreacion = !_modoCreacion;
    });
  }

  void _onTap(LatLng point) {
    if (!_modoCreacion) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return CreateMarkerPage(point);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _modoCreacion
      ? AppBar(title: Text('Toca el mapa para crear un marcador'),)
      : null,
      floatingActionButton: ButtonCreateMarker(onPressed: _activarModoCreacion,),
      body: FlutterMap(
        options: MapOptions(
          onTap: _onTap,
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
      ),
    );
  }
}
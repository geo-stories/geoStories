import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/components/btn_createmarker.dart';
import 'package:geo_stories/components/main_drawer.dart';
import 'package:geo_stories/components/marker_icon.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:latlong/latlong.dart';
import 'package:geo_stories/screens/create_marker_page.dart';
import '../constants.dart';
import '../enums.dart';

class MapPage extends StatefulWidget {

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MarkerPage form;
  MapModo _modo = MapModo.explorar;
  String _modoHeaderTitle = MapModo.explorar.name;

  @override
  void initState() {
    super.initState();
  }

  void _toggleModo() {
    setState(() {
      if (_modo == MapModo.explorar) {
        _modo = MapModo.crearMarker;
        _modoHeaderTitle = _modo.name;
      } else {
        _modo = MapModo.explorar;
        _modoHeaderTitle = _modo.name;
      }
    });
  }

  void _onTap(LatLng point) {
    if (_modo != MapModo.explorar) {
      _toggleModo();
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return CreateMarkerPage(point);
      }));
    }
  }

  List<Marker> _markers(List<QueryDocumentSnapshot> documents) {

    final markerDtos = documents.map((document) => MarkerDTO.fromJSON(document.data(), document.id)).toList();
    return markerDtos.map((markerDto) {
      return Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 50.0,
        height: 50.0,
        point: LatLng(markerDto.latitude , markerDto.longitude),
        builder: (ctx) => MarkerIcon(markerDto),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(_modoHeaderTitle), backgroundColor: kColorLightblue),
      floatingActionButton: ButtonCreateMarker(onPressed: _toggleModo),
      body: StreamBuilder<QuerySnapshot>(
        stream: MarkerService.getMarkerSnapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasData) {
            return FlutterMap(
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
                  markers: _markers(snapshot.data.docs),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

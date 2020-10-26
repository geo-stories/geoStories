import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/services/marker.service.dart';
import 'package:latlong/latlong.dart';

import '../main.dart';

class CreateMarkerPage extends StatefulWidget{
  LatLng point;
  CreateMarkerPage(LatLng point){
    this.point = point;
  }

  @override
  MarkerPage createState() => MarkerPage(point);

}
class MarkerPage extends State<CreateMarkerPage> {
  LatLng point;
   TextEditingController nameTextController ;
   TextEditingController descriptTextController ;

  MarkerPage(LatLng point){
    this.point=point;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar un nuevo marker "),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
      child : Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration (labelText: "Nombre del marker",
              hintText: "Un identificador del marker"
            ),
            controller: nameTextController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Descripción del marker",
            hintText: "Algo que describa el market"),
            controller: descriptTextController,
          ),
          RaisedButton(
              child: Text("Guardar Marker"),
              onPressed: (){
                _tocoElVoton(context);
              }
          )
        ],
      ),
    )
    );
  }
  void _tocoElVoton(BuildContext context){
    MarkerService.createMarker(nameTextController.text,descriptTextController.text,point);
    nameTextController.clear();
    descriptTextController.clear();
    print(point);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()));

  }
  @override
  void initState() {
    nameTextController = TextEditingController();
    descriptTextController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameTextController.dispose();
    descriptTextController.dispose();
    super.dispose();
  }
}


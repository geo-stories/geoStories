import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/services/marker.service.dart';

import 'map_page.dart';

class CreateMarkerPage extends StatefulWidget{
  @override
  _CreateMarkerPage createState() => _CreateMarkerPage();

}
class _CreateMarkerPage extends State<CreateMarkerPage> {
   TextEditingController nameTextController ;
   TextEditingController descriptTextController ;


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
    MarkerService.createMarker(nameTextController.text,descriptTextController.text);
    nameTextController.clear();
    descriptTextController.clear();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapPage()));

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


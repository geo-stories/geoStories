import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:latlong/latlong.dart';

import '../main.dart';

class EditMarker extends StatefulWidget{
  MarkerDTO dto;

  EditMarker(MarkerDTO dto){
    this.dto = dto;
  }

  @override
  EditMarkerPage createState() => EditMarkerPage(dto);

}
class EditMarkerPage extends State<EditMarker> {
  MarkerDTO dto;
  TextEditingController titleTextController;
  TextEditingController descriptTextController;

  EditMarkerPage(MarkerDTO dto){
    this.dto = dto;

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar un nuevo marker "),
        ),
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child : Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration (labelText: "Título",
                    hintText: dto.title,
                  border: OutlineInputBorder(),
                ),
                controller: titleTextController,
                key: ValueKey("field1"),


              ),

              TextField(
                decoration: InputDecoration(labelText: "Descripción",
                    hintText: dto.description,
                  border: OutlineInputBorder(),),
                controller: descriptTextController,
                key: ValueKey("field2"),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                  child: Text("Guardar"),
                  onPressed: () {
                    if (titleTextController.value.text != "" && descriptTextController.value.text != "") {
                      _updateMarker(context);
                    } else {
                      showDialog(context: context, child:
                      new AlertDialog(
                          title: new Text("Por favor, ingrese un título o una descripción."),
                          actions: [
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ]
                      ));
                    }
                  }
              ),
              const SizedBox(height: 30),
              RaisedButton(
                child: Text("Cancelar"),

                onPressed: () {
                  _navigateToMap(context);
                }
              )
            ],
          ),
        )
    );
  }
  void _updateMarker(BuildContext context){
   MarkerService.updateMarker(titleTextController.value.text, descriptTextController.value.text, dto);
    _navigateToMap(context);

  }

  void _navigateToMap(BuildContext context){
      titleTextController.clear();
      descriptTextController.clear();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapPage()));
  }




  @override
  void initState() {
    titleTextController = new TextEditingController(text: dto.title);
    descriptTextController = new TextEditingController(text: dto.description);
    super.initState();
  }
  @override
  void dispose() {
    titleTextController.dispose();
    descriptTextController.dispose();
    super.dispose();
  }
}


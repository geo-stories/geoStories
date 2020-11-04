import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/edit_marker_page.dart';

class MarkerIcon extends StatelessWidget {
  final MarkerDTO markerDTO;

  const MarkerIcon({
    Key key, this.markerDTO
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_on),
      iconSize: 50.0,
      color: Colors.red,
      onPressed: () {
        _MarkerModalInfo(context);
      },
    );
  }

  void _MarkerModalInfo(BuildContext context) {
    showDialog(
        context: context,
        child: new AlertDialog(
          backgroundColor: Colors.white70,
          title: Text(this.markerDTO.title),
          content: Text(this.markerDTO.description),
          actions: [
            IconButton(
                key: ValueKey("DeleteButton"),
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  //BORRAR EL MARCADOR
                }),
            IconButton(
              key: ValueKey("EditButton"),
              icon : Icon(Icons.edit),
              color: Colors.black,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditMarker(markerDTO);
                }));

              },
            )
          ],
        )
      );
  }
}
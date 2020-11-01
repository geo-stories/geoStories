import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';

class MarkerIcon extends StatelessWidget {
  //final String titulo = "Test";

  const MarkerIcon({
    Key key, String titulo,
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
          title: Text('titulo'),
          content: Text('Completar con datos del marcador'),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  //BORRAR EL MARCADOR
                }),
          ],
        )
      );
  }
}
import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';

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
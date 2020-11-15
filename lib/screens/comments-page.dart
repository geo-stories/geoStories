import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:latlong/latlong.dart';

import '../main.dart';

class CommentsPage extends StatefulWidget{
  MarkerDTO markerDTO;
  CommentsPage(MarkerDTO markerDTO){
    this.markerDTO = markerDTO;
  }

  @override
  CommentsPageState createState() => CommentsPageState(markerDTO);

}
class CommentsPageState extends State<CommentsPage> {
  MarkerDTO markerDTO;

  CommentsPageState(MarkerDTO markerDTO){
    this.markerDTO = markerDTO;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(markerDTO.title),
        ),
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child : Column(
            children: <Widget>[

            ],
          ),
        )
    );
  }

import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/edit_marker_page.dart';

class MarkerIcon extends StatefulWidget {
  MarkerDTO markerDTO;

  MarkerIcon(MarkerDTO markerDTO){
      this.markerDTO = markerDTO;
  }

  @override
  State<StatefulWidget> createState() {
    return _MarkerIconState(markerDTO);
  }

}

class _MarkerIconState extends State<MarkerIcon> {
  MarkerDTO markerDTO;
  String idUser;
  bool _likes;

  _MarkerIconState(MarkerDTO markerDTO) {
    this.markerDTO = markerDTO;
    this.idUser = markerDTO.id;
    this._likes = true;
  }


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
/*IconButton(
   onPressed: () {
       setState(() {
           _likes[index] = !_likes[index];
       });
       }
   },
   icon: Icon(Constants.crownIcon, color: _likes[index] ? Constants.orangeColor :
Constants.ligthGreyColor, size: 15.0),
),*/
  void _MarkerModalInfo(BuildContext context) {
    showDialog(
        context: context,
        child: new AlertDialog(
          backgroundColor: Colors.white70,
          title: Text(this.markerDTO.title),
          content: Text(this.markerDTO.description),
          actions: [
            IconButton(
              key: ValueKey("LikeButton"),
                icon: Icon(Icons.favorite_rounded, color: _likes ? Colors.red :
                Colors.black, size: 15.0),
                  onPressed: () {
                    setState(() {
                    _likes = !_likes;
                    });
                  }
            ),

            //TODO: aplicar lo del conntainer!!!

            IconButton(
                key: ValueKey("DeleteButton"),
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  //BORRAR EL MARCADOR
                }),
            IconButton(
              key: ValueKey("EditButton"),
              icon : Icon(Icons.edit_outlined),
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


  Icon _isLiked(){
    if(_likes){
      return Icon(Icons.favorite_rounded , color: Colors.red);
    }
    else {
      return Icon(Icons.favorite_border_rounded , color: Colors.black);
    }
  }

  bool _userLikedIt() {
    return true;
  }
}


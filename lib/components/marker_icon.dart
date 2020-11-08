import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/edit_marker_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:like_button/like_button.dart';

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
            LikeButton(
              circleColor:
              CircleColor(start: Color(0xffffeb3b), end: Color(0xffb71c1c)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xffffeb3b),
                dotSecondaryColor: Color(0xffb71c1c),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite_rounded,
                  color: isLiked ? Colors.red[800] : Colors.grey,
                );
              },
              likeCount: markerDTO.likes?.length,
              isLiked: _userLikedIt(),
              onTap: onLikeButtonTapped,

            ),
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
  bool _userLikedIt() {
    final user = UserService.getCurrentUser();
    return user != null &&  markerDTO.likes?.contains(user.uid);
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    String uid = UserService.getCurrentUser().uid;
    MarkerService.refreshLikes(markerDTO.id, uid, isLiked);

    return !isLiked;
  }



}

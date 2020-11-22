import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/comments_page.dart';
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

  Future<void> _MarkerModalInfo(BuildContext context) async {
    showDialog(
        context: context,
        child: new AlertDialog(
          backgroundColor: Colors.white70,
          title: Text(markerDTO.title, textAlign: TextAlign.center,),
          content: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: ' •' + await MarkerService.GetOwnerUsername(markerDTO.owner) + '• ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(text: markerDTO.description, style: TextStyle(color: Colors.grey[900])),
              ],
            ),
          ),
          actions: [
            _likeButton(),
            _editButton(context),
            _commentButton(context),
          ],
        )
    );
  }

  IconButton _commentButton(BuildContext context) {
    return IconButton(
            key: ValueKey("CommentsButton"),
            icon : Icon(Icons.chat_bubble_outline_rounded),
            color: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CommentsPage(markerDTO);
              }));
            },
          );
  }

  IconButton _editButton(BuildContext context) {
    if(UserService.isMarkerOwner(markerDTO.owner)) {
      return IconButton(
        key: ValueKey("EditButton"),
        icon: Icon(Icons.edit_outlined),
        color: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditMarker(markerDTO);
          }));
        },
      );
    }
  }

  LikeButton _likeButton() {
    return LikeButton(
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
          );
  }
  bool _userLikedIt() {
    final bool isUserAnon = UserService.isAnonymousUser();
    final user = UserService.getCurrentUser();
    return !isUserAnon && markerDTO.likes.contains(user.uid);
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    final bool isUserAnon = UserService.isAnonymousUser();
    if(!isUserAnon) {
      String uid = UserService
          .getCurrentUser()
          .uid;
      MarkerService.refreshLikes(markerDTO.id, uid, isLiked);
      return !isLiked;
    }
    else{
      return isLiked;
    }
  }
}

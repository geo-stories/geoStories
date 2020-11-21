import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/screens/comments_page.dart';
import 'package:geo_stories/screens/edit_marker_page.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import 'package:like_button/like_button.dart';

class MarkerIcon extends StatefulWidget  {
  final MarkerDTO markerDTO;

  MarkerIcon({this.markerDTO});

  @override
  _MarkerIconState createState() => _MarkerIconState();
}

class _MarkerIconState extends State<MarkerIcon>{
  int commentsCounter;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_on),
      iconSize: 50.0,
      color: Colors.red,
      onPressed: () {
        _showMarkerModalInfo(context);
      },
    );
  }

  void _showMarkerModalInfo(BuildContext context) {
    commentsCounter = widget.markerDTO.comments.length;
    showDialog(
        context: context,
        child: new AlertDialog(
          backgroundColor: Colors.white70,
          title: Text(widget.markerDTO.title, textAlign: TextAlign.center,),
          content: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: ' •' + widget.markerDTO.owner + '• ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(text: widget.markerDTO.description, style: TextStyle(color: Colors.grey[900])),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
          actions: [
            IconButton(
              key: ValueKey("EditButton"),
              icon : Icon(Icons.edit_outlined),
              color: Colors.black,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditMarker(widget.markerDTO);
                }));
              },
            ),
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
              likeCount: widget.markerDTO.likes?.length,
              isLiked: _userLikedIt(),
              onTap: onLikeButtonTapped,
            ),

            Container(
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CommentsPage(widget.markerDTO);
                        }));
                      }
                  ),
                  Text(this.commentsCounter.toString())
                ],
              ),
            ),
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
    return !isUserAnon && widget.markerDTO.likes.contains(user.uid);
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    final bool isUserAnon = UserService.isAnonymousUser();
    if(!isUserAnon) {
      String uid = UserService
          .getCurrentUser()
          .uid;
      MarkerService.refreshLikes(widget.markerDTO.id, uid, isLiked);
      return !isLiked;
    }
    else{
      return isLiked;
    }
  }


}
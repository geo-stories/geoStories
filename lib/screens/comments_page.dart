import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/action_icon_button.dart';
import 'package:geo_stories/components/Ui/rounded_textbox_field.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';

import '../constants.dart';

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
  String commentText = "";
  bool _isAnonymousUser = UserService.isAnonymousUser();
  String _userId = UserService.getCurrentUser()?.uid;

  CommentsPageState(MarkerDTO markerDTO) {
    this.markerDTO = markerDTO;
  }

  Widget makeComment() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RoundedTextboxField(
              hintText: "Escribe una respuesta...",
              maxLength: 140,
              onChanged: (value) {
                this.commentText = value;
                print(this.commentText);
              }),
          ActionIconButton(
              icon: this.commentText.length > 0 ? Icon(Icons.send_rounded , color: kColorOrange, size: 35,)
                  : Icon(Icons.send_rounded , color: Colors.grey, size: 35,),
              press: () {
                if(!this._isAnonymousUser && this.commentText.length > 0) {
                  MarkerService.addComment(markerDTO.id, _userId, this.commentText);
                }
              })
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(markerDTO.title),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: makeComment(),
    );
  }
}

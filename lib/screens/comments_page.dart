import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/action_icon_button.dart';
import 'package:geo_stories/components/Ui/rounded_textbox_field.dart';
import 'package:geo_stories/models/comment_dto.dart';
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
  Color _sendCommentButtonColor = Colors.grey;
  bool _isAnonymousUser = UserService.isAnonymousUser();
  String _userId = UserService.getCurrentUser()?.uid;

  CommentsPageState(MarkerDTO markerDTO) {
    this.markerDTO = markerDTO;
  }

  Widget getCommentListFromMarker(DocumentSnapshot markerDoc) {
    var markerData = markerDoc.data();
    MarkerDTO _markerDTO = MarkerDTO.fromJSON(markerData, markerDTO.id);
    List<CommentDTO> _comments = _markerDTO.comments.map((comment) => CommentDTO.fromJSON(comment)).toList();
    return new Column(children: <Widget>[
      for(var comment in _comments ) Text(comment.text)
    ],);
  }

  Future<AlertDialog> _alertDialog(String alertText) {
    return showDialog(
        context: context,
        child: new AlertDialog(
            key: ValueKey(alertText),
            title: new Text(alertText),
            actions: [
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]
        ));
  }

  bool _commentTextIsEmpty() {
    return commentText.trim().isEmpty;
  }

  void _resetCommentTextbox() {
    setState(() {
      this.commentText = "";
    });
    FocusScope.of(context).unfocus();
  }

  void _publishComment() {
    if(!this._isAnonymousUser && !_commentTextIsEmpty()) {
      MarkerService.addComment(markerDTO.id, _userId, this.commentText)
          .then((_) => _alertDialog("Comentario publicado con éxito!"))
          .then((_) => _resetCommentTextbox())
          .catchError((_) => _alertDialog("Ha ocurrido un error. Por favor, intente de nuevo más tarde."));
    } else if (this._isAnonymousUser) {
      _alertDialog("Por favor, inicie sesión para comentar.");
    } else if (_commentTextIsEmpty()) {
      _alertDialog("Por favor, ingrese un comentario válido.");
    }
  }

  Widget makeComment() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RoundedTextboxField(
              hintText: _isAnonymousUser ? "Por favor, inicie sesión para comentar." : "Escribe una respuesta...",
              maxLength: 140,
              onChanged: (value) {
                this.commentText = value;
                setState(() {
                  this._sendCommentButtonColor = (!_commentTextIsEmpty()) ? kColorOrange : Colors.grey;
                });
              }),
          ActionIconButton(
              icon: Icon(Icons.send_rounded , color: _sendCommentButtonColor, size: 35),
              key: ValueKey('SendComment'),
              press: _publishComment
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBgLightgrey,
      body: StreamBuilder<DocumentSnapshot>(
        stream: MarkerService.getSingleMarkerSnapshots(markerDTO.id),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            var marker = snapshot.data;
            return getCommentListFromMarker(marker);
          }
          return Container();
        },
      ),
      appBar: AppBar(
        title: Text(markerDTO.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: makeComment(),
    );
  }

}
class CommentDTO {
  final String text;
  final String userId;
  final String id;

  CommentDTO({this.text, this.userId, this.id});

  factory CommentDTO.fromJSON(Map<String,dynamic> json) {
    return CommentDTO(
        text: json['text'],
        userId: json['userId'],
        id: json['commentId']
    );
  }
}

class MarkerDTO {
  final String title;
  final String description;
  final num latitude;
  final num longitude;
  final String id;
  final List<dynamic> likes;
  final String owner;
  final List<Object> comments;

  MarkerDTO({this.title, this.description, this.latitude, this.longitude, this.id, this.likes, this.owner, this.comments});

  factory MarkerDTO.fromJSONWithId(Map<String,dynamic> json, String id) {
    return MarkerDTO(
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      likes: json['likes'],
      owner: json['owner'],
      comments: json['comments'],
      id: id
    );
  }

  factory MarkerDTO.fromJSON(Map<String,dynamic> json) {
    return MarkerDTO(
        title: json['title'],
        description: json['description'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        likes: json['likes'],
        owner: json['owner'],
        comments: json['comments'],
    );
  }

}

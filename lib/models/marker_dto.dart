class MarkerDTO {
  final String title;
  final String description;
  final num latitude;
  final num longitude;
  final String id;
  final List<dynamic> likes;
  final String owner;

  MarkerDTO({this.title, this.description, this.latitude, this.longitude, this.id, this.likes, this.owner});

  factory MarkerDTO.fromJSON(Map<String,dynamic> json, String id) {
    return MarkerDTO(
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      likes: json['likes'],
      owner: json['owner'],
      id: id
    );
  }
}

class MarkerDTO {
  final String title;
  final String description;
  final num latitude;
  final num longitude;
  final String id;
  final List<dynamic> likes;

  MarkerDTO({this.title, this.description, this.latitude, this.longitude, this.id, this.likes});

  factory MarkerDTO.fromJSON(Map<String,dynamic> json, String id) {
    return MarkerDTO(
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      likes: json['likes'],
      id: id
    );
  }
}

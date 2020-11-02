class MarkerDTO {
  final String title;
  final String description;
  final num latitude;
  final num longitude;

  MarkerDTO({this.title, this.description, this.latitude, this.longitude});

  factory MarkerDTO.fromJSON(Map<String, dynamic> json) {
    return MarkerDTO(
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

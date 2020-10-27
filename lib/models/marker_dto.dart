class MarkerDTO {
  final String name;
  final String description;
  final num latitude;
  final num longitude;

  MarkerDTO({this.name, this.description, this.latitude, this.longitude});

  factory MarkerDTO.fromJSON(Map<String, dynamic> json) {
    return MarkerDTO(
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

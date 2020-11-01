class UserDTO {
  final String name;
  final String lastname;

  UserDTO({this.name, this.lastname});

  factory UserDTO.fromJSON(Map<String, dynamic> json) {
    return UserDTO(
        name: json['nombre'],
        lastname: json['apellido']
    );
  }
}
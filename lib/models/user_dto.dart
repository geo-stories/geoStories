class UserDTO {
  final String username;
  final String avatarUrl;

  UserDTO({this.username, this.avatarUrl});

  factory UserDTO.fromJSON(Map<String, dynamic> json) {
    return UserDTO(
        username: json['username'],
        avatarUrl: json['avatarUrl']
    );
  }
}
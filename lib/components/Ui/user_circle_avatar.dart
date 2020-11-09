import 'package:flutter/material.dart';

class UserCircleAvatar extends StatefulWidget {
  final double radius;
  final String avatarURL;

  const UserCircleAvatar({
    Key key,
    this.radius, this.avatarURL,
  }) : super(key: key);

  _UserCircleAvatarState createState() => _UserCircleAvatarState(avatarURL);
}

class _UserCircleAvatarState extends State<UserCircleAvatar> {
  String avatarURL;
  bool avatarTypeAsset;

  _UserCircleAvatarState(String avatarURL){
    this.avatarURL = avatarURL;
    avatarURL.startsWith('assets') ? this.avatarTypeAsset = true : avatarTypeAsset = false;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (super.widget.radius + 3),
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: super.widget.radius,
        backgroundImage: avatarTypeAsset ? AssetImage(avatarURL) : NetworkImage(avatarURL),
      )
    );
  }
}
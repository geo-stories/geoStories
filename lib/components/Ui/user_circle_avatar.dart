import 'package:flutter/material.dart';

class UserCircleAvatar extends StatefulWidget {
  final double radius;

  const UserCircleAvatar({
    Key key,
    this.radius,
  }) : super(key: key);

  _UserCircleAvatarState createState() => _UserCircleAvatarState();
}

class _UserCircleAvatarState extends State<UserCircleAvatar> {
  String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (super.widget.radius + 3),
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: super.widget.radius,
        backgroundImage: AssetImage('assets/images/user.jpg'),
      )
    );
  }
}
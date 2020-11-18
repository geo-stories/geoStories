import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLocationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_history),
      iconSize: 50.0,
      color: Colors.blueGrey,
      onPressed: () {
      },
    );
  }
}

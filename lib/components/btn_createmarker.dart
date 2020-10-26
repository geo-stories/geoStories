import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class ButtonCreateMarker extends StatelessWidget {
  final Function onPressed;
  ButtonCreateMarker({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add_location_outlined),
        backgroundColor: Colors.orange,
    );
  }
}


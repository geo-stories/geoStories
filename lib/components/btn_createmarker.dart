import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class ButtonCreateMarker extends StatelessWidget {
  final Function onPressed;
  final bool isAnonymousUser;
  ButtonCreateMarker({this.onPressed, this.isAnonymousUser});

  @override
  Widget build(BuildContext context) {
    if(!isAnonymousUser){
      return FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add_location_outlined, size: 45),
        backgroundColor: Colors.orange,
      );
    }
    else{
      return FloatingActionButton(
        child: Icon(Icons.add_location_outlined),
        backgroundColor: Colors.grey,
      );
    }

  }
}


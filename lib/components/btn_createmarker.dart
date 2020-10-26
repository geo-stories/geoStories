import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




/// This is the stateless widget that the main application instantiates.
class ButtonCreateMarker extends StatelessWidget {
  ButtonCreateMarker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add_location_outlined),
        backgroundColor: Colors.orange,
    );
  }
}


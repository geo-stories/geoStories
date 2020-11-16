import 'package:flutter/material.dart';
import 'package:geo_stories/constants.dart';

class ActionIconButton extends StatelessWidget {
  final Icon icon;
  final Function press;
  //final double width;
  const ActionIconButton({
    Key key,
    this.icon,
    this.press,
   // this.width = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding:const EdgeInsets.all(0.0),
        key: key,
        icon : icon,
        onPressed: press
    );
  }
}

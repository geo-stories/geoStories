import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final Icon icon;
  final Function press;

  const ActionIconButton({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding:const EdgeInsets.all(0.0),
        icon : icon,
        onPressed: press
    );
  }
}

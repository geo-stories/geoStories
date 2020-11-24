import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class ActionButton extends StatelessWidget {
  final Function onPressed;
  final bool isAnonymousUser;
  final Icon icon;
  ActionButton({this.onPressed, this.isAnonymousUser, this.icon});

  @override
  Widget build(BuildContext context) {
    if(!isAnonymousUser){
      return FloatingActionButton(
        key: Key('boton-crear-marker'),
        onPressed: onPressed,
        child: icon,
        backgroundColor: Colors.orange,
        heroTag: 'action-button',
      );
    }
    else{
      return FloatingActionButton(
        child: icon,
        backgroundColor: Colors.grey,
        heroTag: 'action-button-disabled',
      );
    }

  }
}


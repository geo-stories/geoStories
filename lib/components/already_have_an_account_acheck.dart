import 'package:flutter/material.dart';
import 'package:geo_stories/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "¿Todavía no tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Registrate" : "Iniciar sesión",
            style: TextStyle(
              color: kColorOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

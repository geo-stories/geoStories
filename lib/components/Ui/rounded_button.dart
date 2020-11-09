import 'package:flutter/material.dart';
import 'package:geo_stories/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kColorOrange,
    this.textColor = Colors.white,
    this.width = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

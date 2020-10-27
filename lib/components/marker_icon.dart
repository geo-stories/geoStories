import 'package:flutter/material.dart';

class MarkerIcon extends StatelessWidget {
  const MarkerIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.location_on,
      color: Colors.red,
      size: 60,
    );
  }
}

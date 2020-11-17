import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

/// This is the stateless widget that the main application instantiates.
class ButtonLocation extends StatefulWidget {
   _ButtonLocationState createState() => _ButtonLocationState();
}

  class _ButtonLocationState extends State<ButtonLocation> {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    Future<void> onTap() async{
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      _locationData = await location.getLocation();
    }
    @override
    Widget build(BuildContext context) {
      return FloatingActionButton(onPressed: onTap);
    }


  }

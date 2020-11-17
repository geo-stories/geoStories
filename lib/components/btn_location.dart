import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/components/user_location_icon.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';

class ButtonLocation extends StatefulWidget {
  final Function callback;

  ButtonLocation({this.callback});

  _ButtonLocationState createState() => _ButtonLocationState();
}

class _ButtonLocationState extends State<ButtonLocation> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<void> onTap() async {
    if (_locationData != null) {
      _serviceEnabled = false;
      _locationData = null;
      widget.callback(null);
      return;
    }
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

    widget.callback(_userMarker());
  }

  Marker _userMarker() {
    return Marker(
      anchorPos: AnchorPos.align(AnchorAlign.top),
      width: 50.0,
      height: 50.0,
      point: LatLng(_locationData.latitude, _locationData.longitude),
      builder: (ctx) => UserLocationIcon(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: FloatingActionButton(
        onPressed: onTap,
        heroTag: 'btn-location',
        child: Icon(Icons.location_history),
      ),
    );
  }
}

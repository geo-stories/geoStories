import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/marker_dto.dart';
import 'package:geo_stories/services/marker_service.dart';
import 'package:geo_stories/services/user_service.dart';
import '../constants.dart';
import 'package:latlong/latlong.dart';

class MyMarkersPage extends StatefulWidget {
  final MapController mapController;

  const MyMarkersPage({Key key, this.mapController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyMarkersPageState();
  }
}

class MyMarkersPageState extends State<MyMarkersPage> {
  int itemNumber = 0;
  List<Widget> itemsData = [];

  Future<void> getPostsData() async {
    List<MarkerDTO> responseList = await MarkerService.GetMarkersDTOByOwner(UserService.GetUserId());
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 125,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      post.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )),
                FloatingActionButton(
                  onPressed: () => onPressButton(post),
                  heroTag: 'btnItemMarker' + nextId(),
                  child: Icon(Icons.location_on_rounded),
                ),
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  void onPressButton(MarkerDTO markerDTO) {
    print('btnItemMarker' + nextId());
    widget.mapController.move(LatLng(markerDTO.latitude, markerDTO.longitude), 16);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Mis marcadores"), backgroundColor: kColorLightblue),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(24),
        child: itemsData.length == 0 ?
        Text('No tiene ningun marcador.') :
        ListView.builder(
          itemCount: itemsData.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return itemsData[index];
          },
        ),
      ),
    );
  }

  String nextId() {
    itemNumber++;
    return itemNumber.toString();
  }

}
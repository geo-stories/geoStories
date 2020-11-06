
import 'package:flutter/material.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:geo_stories/screens/edit_marker_page.dart';
import 'package:geo_stories/screens/edit_user_page.dart';
import 'package:geo_stories/screens/login_page.dart';

import '../constants.dart';
import 'Ui/user_circle_avatar.dart';
class MainDrawer extends StatefulWidget {

  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                  children: <Widget>[
                    Center(
                        child: UserCircleAvatar(
                          radius: 50
                        ),
                      ),
                    SizedBox(height: 5),
                    Text(
                      'Anónimo',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
            decoration: BoxDecoration(
                color: kColorLightblue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(''))),
          ),

          ListTile(
            leading: Icon(Icons.edit),
            title: Transform(
              transform: Matrix4.translationValues(-10, 0.0, 0.0),
              child: Text("Configuración",
                  style: TextStyle(fontSize: 18)),
            ),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context){
              return FormEditUserScreen(new UserDTO(username: 'Pepe',avatarUrl: 'asd'));
              }))},
          ),
        ],
      ),
    );
  }
}
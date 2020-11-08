import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:geo_stories/screens/edit_user_page.dart';
import 'package:geo_stories/services/user_service.dart';
import '../constants.dart';
import 'Ui/user_circle_avatar.dart';

class MainDrawer extends StatefulWidget {
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  User user;
  bool userIsAuthenticated;
  String userName;

  @override
  void initState() {
    super.initState();
    UserService.getCurrentUser() == null ? this.userIsAuthenticated = false : this.user = UserService.getCurrentUser();
    this.user != null ? this.userName = user.displayName : this.userName = "Anónimo";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildAvatar(userName),
          _buildConfig(context, userIsAuthenticated),
        ],
      ),
    );
  }

  DrawerHeader _buildAvatar(String _name) {
    return DrawerHeader(
          child: Column(
                children: <Widget>[
                  Center(
                      child: UserCircleAvatar(
                        radius: 50
                      ),
                    ),
                  SizedBox(height: 5),
                  Text(
                    _name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
                  )
                ],
              ),
          decoration: BoxDecoration(
              color: kColorLightOrange,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(''))),
        );
  }

  ListTile _buildConfig(BuildContext context, bool _enableEdit) {
    return ListTile(
      enabled: _enableEdit,
      leading: Icon(Icons.settings_rounded,),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Configuración",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () =>
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormEditUserScreen(new UserDTO(username: 'Pepe',
              avatarUrl: 'https://i.postimg.cc/rz6rd0K1/fox-flutter.png'));
        }))},
    );
  }
}
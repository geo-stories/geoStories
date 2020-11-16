import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:geo_stories/screens/edit_password_page.dart';
import 'package:geo_stories/screens/edit_user_page.dart';
import 'package:geo_stories/screens/login_page.dart';
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
  String avatarURL;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() {
    if (!UserService.isAnonymousUser()) {
      this.userIsAuthenticated = true;
      this.user = UserService.getCurrentUser();
      this.userName = user.displayName ?? "New User";
      this.avatarURL = user.photoURL ?? kAvatarNotUser;
    }
    else{
      this.userIsAuthenticated = false;
      this.userName = "Anónimo";
      this.avatarURL = kAvatarNotUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildAvatar(userName, avatarURL),
          _buildConfig(context, userIsAuthenticated),
          _changePassword(context, userIsAuthenticated),
          _buildLogOut (context, userIsAuthenticated),
        ],
      ),
    );
  }

  DrawerHeader _buildAvatar(String _name, String _avatarURL) {
    return DrawerHeader(
          child: Column(
                children: <Widget>[
                  Center(
                      child: UserCircleAvatar(
                        radius: 50,
                        avatarURL: _avatarURL,
                      ),
                    ),
                  SizedBox(height: 5),
                  Text(
                    _name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
                  )
                ],
              ),
          decoration: BoxDecoration( color: kColorLightOrange),
        );
  }
  ListTile _buildLogOut(BuildContext context, bool _enableEdit) {
    return ListTile(
      key: ValueKey("logOut"),
      enabled: _enableEdit,
      leading: Icon(Icons.vpn_key_outlined,),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Log Out",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => {
        UserService.GetUsername(),
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }))},
    );
  }

  ListTile _buildConfig(BuildContext context, bool _enableEdit) {
    return ListTile(
      key: ValueKey("editNick"),
      enabled: _enableEdit,
      leading: Icon(Icons.settings_rounded,),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Configuración",
        style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormEditUserScreen(new UserDTO(username: this.userName, avatarUrl: this.avatarURL));
        }))},
    );
  }

  ListTile _changePassword(BuildContext context, bool _enableEdit) {
    return ListTile(
      enabled: _enableEdit,
      leading: Icon(Icons.vpn_key_outlined,key: ValueKey("EditPassword"),),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Cambiar contraseña",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) {
          return PasswordEditPage();
        })
      )},
    );
  }
}
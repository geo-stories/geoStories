import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:geo_stories/screens/edit_password_page.dart';
import 'package:geo_stories/screens/edit_user_page.dart';
import 'package:geo_stories/screens/my_markers_page.dart';
import 'package:geo_stories/services/user_service.dart';
import '../constants.dart';
import '../screens/signup_page.dart';
import '../screens/welcome_page.dart';
import 'Ui/user_circle_avatar.dart';

class MainDrawer extends StatefulWidget {
  final MapController mapController;

  const MainDrawer({Key key, this.mapController}) : super(key: key);

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
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildAvatar(userName, avatarURL),
                _buildConfig(context, userIsAuthenticated),
                _changePassword(context, userIsAuthenticated),
                _misMarcadores(context, userIsAuthenticated),
              ],
            ),
          ),
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Divider(),
                          userIsAuthenticated ? _logout(context) : _register(context),
                        ],
                      )
                  )
              )
          )
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
          decoration: BoxDecoration( color: kColorLightblue),
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

  ListTile _register(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.how_to_reg),key: ValueKey("Register"),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Registrarse",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () async => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUpPage();
        }))},
    );
  }

  ListTile _logout(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),key: ValueKey("Logout"),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Cerrar sesión",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () async => {
        await UserService.disconnect(),
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WelcomePage();
        }))},
    );
  }

  ListTile _misMarcadores(BuildContext context, bool _enableEdit) {
    return ListTile(
      enabled: _enableEdit,
      leading: Icon(Icons.map),key: ValueKey("MisMarcadores"),
      title: Transform(
        transform: Matrix4.translationValues(-20, 0.0, 0.0),
        child: Text("Mis Marcadores",
            style: TextStyle(fontSize: 18)),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) {
          return MyMarkersPage(mapController: widget.mapController);
        })
      )},
    );
  }

}
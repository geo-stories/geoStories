
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:geo_stories/services/user_service.dart';

import '../constants.dart';

class FormEditUserScreen extends StatefulWidget {
  UserDTO userDTO;

  FormEditUserScreen(UserDTO dto){
    this.userDTO = dto;
  }

  @override
  State<StatefulWidget> createState() {
    return FormEditUserScreenState(userDTO);
  }
}

class FormEditUserScreenState extends State<FormEditUserScreen> {
  UserDTO userDTO;
  String _username;
  String _avatar;
  bool _avatarTypeAsset;
  bool isLoading;
  TextEditingController userName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormEditUserScreenState(UserDTO userDTO){
    this.userDTO = userDTO;
    this._username = userDTO.username;
    this._avatar = userDTO.avatarUrl;
    _avatar.startsWith('assets') ? this._avatarTypeAsset = true : _avatarTypeAsset = false;
    this.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración de Usuario"), backgroundColor: kColorLightblue,),
      body: Container(
        margin: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildAvatar(),
                SizedBox(height: 20),
                _buildName(),
                SizedBox(height: 100),
                Container(
                  child: isLoading ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorOrange)),
                                      Text("Aplicando cambios")],
                  ) :
                RoundedButton(
                  key: ValueKey("Guardar Nuevo Nick"),
                  text: "Guardar",
                  width: 0.4,
                  press: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    setState(() {
                      isLoading = true;
                    });
                    await UserService.updateCurrentUserProfile(new UserDTO(username: _username, avatarUrl: _avatar));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
        backgroundImage: _avatarTypeAsset ? AssetImage(_avatar) : NetworkImage(_avatar),
        radius: 50,
        child: IconButton(
          icon: Icon(Icons.edit),
          splashColor: Colors.red,
          iconSize: 50.0,
          color: Colors.white60,
          onPressed: () {
            _buildDialogChangeAvatar();
          },
        )
    );
  }

  void _buildDialogChangeAvatar() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: Text("Cambiar Imagen"),
          content: TextFormField(
              decoration: InputDecoration(labelText: 'URL'),
              initialValue: _avatarTypeAsset ? '' : _avatar,
              onChanged: (String value) {
                _avatar = value;
                _avatar.startsWith('assets') ? this._avatarTypeAsset = true : _avatarTypeAsset = false;
              },
          ),
        )
    );
  }

  Widget _buildName() {
    return TextFormField(
      key: ValueKey("nombreUsuarioCampo"),
      decoration: InputDecoration(labelText: 'Nombre de Usuario'),
      initialValue: _username,
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre de usuario es requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }
}







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/user_circle_avatar.dart';
import 'package:geo_stories/models/user_dto.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormEditUserScreenState(UserDTO userDTO){
    this.userDTO = userDTO;
    this._username = userDTO.username;
    this._avatar = userDTO.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración de Usuario"), backgroundColor: kColorLightOrange,),
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
                RoundedButton(
                  text: "Guardar",
                  width: 0.4,
                  press: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                  },
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
        backgroundImage: NetworkImage(userDTO.avatarUrl),
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
              initialValue: _avatar,
              onSaved: (String value) {
                _avatar = value;
              }
          ),
        )
    );
  }

  Widget _buildName() {
    return TextFormField(
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


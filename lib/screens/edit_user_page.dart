import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/models/user_dto.dart';

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
  String _name;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormEditUserScreenState(UserDTO userDTO){
    this.userDTO = userDTO;
    this._name = userDTO.username;
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre de Usuario'),
      initialValue: _name,
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre de usuario es requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuración de Usuario")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              SizedBox(height: 100),
              RoundedButton(
                text: "Guardar",
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
    );
  }
}


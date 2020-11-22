import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/rounded_password_field.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/user_service.dart';
import '../constants.dart';

class PasswordEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PasswordEditPageState();
  }
}

class PasswordEditPageState extends State<PasswordEditPage> {
  var passwordText1="";
  var passwordText2="";
  bool isLoading = false;
  var services = new UserService();

  Widget _buildChangePassword() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedPasswordField(
            key: ValueKey("PasswordFirstField"),
            hintText: "Nueva contraseña",
            onChanged: (value) {
              this.passwordText1 = value;
            },
          ),
          RoundedPasswordField(
            key: ValueKey("PasswordSecondField"),
            hintText: "Repetir contraseña",
            onChanged: (value) {
              this.passwordText2 = value;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Cambiar Contraseña"), backgroundColor: kColorLightblue),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            _buildChangePassword(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.35),
            Row(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isLoading ? _changePasswordLoader() :
                RoundedButton(
                  key: ValueKey("Guardar PW"),
                  text: "Guardar Cambios",
                  press: () async {
                    await _press(context);
                  },
                )
              ]
            )
          ],
        ),
      ),
    );
  }

  Future _press(BuildContext context) async {
    setState(() { isLoading = true; });
    if (validatePasswordFields(context)) {
      await UserService.updatePassword(this.passwordText1).then((value) => {
        if(value != null) {
          setState(() { isLoading = false; }),
          _throwExceptionFireBase(context, value)
        }
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {return MapPage();}))
        }
      });
    }
    else{
      setState(() { isLoading = false; });
    }
  }

  bool validatePasswordFields(BuildContext context) {
    String errorText;
    if(this.passwordText1 != this.passwordText2){
      errorText = "Las contraseñas no son iguales";
      _throwExceptionEditPassword(context, errorText);
      return false;
    }
    else if(this.passwordText1 == '' || this.passwordText2 == ''){
      errorText = "La contraseña no puede estar vacia";
      _throwExceptionEditPassword(context, errorText);
      return false;
    }
    else if(!validateStructure(this.passwordText1)){
      errorText = "La contraseña no puede tener espacios en blanco";
      _throwExceptionEditPassword(context, errorText);
      return false;
    }
    else {
      return true;
    }
  }

  bool validateStructure(String value){
    ///Se valida que no tenga espacios en blanco.
    String  pattern = r'^(?!.*[\s])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future _throwExceptionEditPassword(BuildContext context, String errorText) {
    return showDialog(
      context: context,
      child: new AlertDialog(
        key: ValueKey("PasswordFailAlert"),
        title: new Text(errorText),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]
      )
    );
  }

  Future _throwExceptionFireBase(BuildContext context, String value) {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: Text("Hubo un error!"),
        content: Text(value),
      )
    );
  }

  Column _changePasswordLoader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorOrange)),
        Text("Cambiando contraseña")],
    );
  }

}
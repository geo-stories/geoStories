import 'package:flutter/material.dart';
import 'package:geo_stories/components/already_have_an_account_acheck.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/rounded_input_field.dart';
import 'package:geo_stories/components/Ui/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/login_page.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/services/user_service.dart';

import '../../constants.dart';
import 'signup_background.dart';

class SignupBody extends StatefulWidget {

  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  bool _isLoading = false;
  String _username = '';
  String _email = '';
  String _password = '';
  String _repeatPassword = '';

  Future<void> _onSubmit(BuildContext context) async {
    if (_username.isEmpty || _email.isEmpty || _password.isEmpty || _repeatPassword.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Dejaste campos sin completar')));
      return;
    }
    if (_username.length > 20) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('El nombre de usuario no puede exceder los 20 caracteres')));
      return;
    }
    if (_password.length <= 5) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres')));
      return;
    }
    if (_password != _repeatPassword) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Las contraseñas no coinciden')));
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      await UserService.register(_email, _password, _username);
      Navigator.push(context, MaterialPageRoute(builder: (context) {return MapPage();}))
        .then((value) {
          setState(() {
            _isLoading = false;
          });
        });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SignUpBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/geostories-logo.svg",
              height: size.height * 0.25,
            ),
            RoundedInputField(
              hintText: "Tu nombre de usuario",
              onChanged: (value) {
                _username = value;
              },
            ),
            RoundedInputField(
              hintText: "Tu E-mail",
              onChanged: (value) {
                _email = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Tu contraseña",
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Repetir contraseña",
              onChanged: (value) {
                _repeatPassword = value;
              },
            ),
            _isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorOrange)),
                    Text("Procesando")
                  ],
                )
              : RoundedButton(
                  text: "Regístrate",
                  press: () => _onSubmit(context),
                ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

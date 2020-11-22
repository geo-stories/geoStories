import 'package:flutter/material.dart';
import 'package:geo_stories/components/already_have_an_account_acheck.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/rounded_input_field.dart';
import 'package:geo_stories/components/Ui/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/map_page.dart';
import 'package:geo_stories/screens/signup_page.dart';
import 'package:geo_stories/services/user_service.dart';

import '../../constants.dart';
import 'login_background.dart';

class LoginBody extends StatefulWidget {
  @override
  LoginWidget createState() => LoginWidget();

  const LoginBody({
    Key key,
  }) : super(key: key);
}

class LoginWidget extends State<LoginBody> {
  String email;
  String password;
  bool _ValidEmail = true;
  bool _ValidPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/geostories-logo.svg",
              height: size.height * 0.28,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              key: ValueKey("Mail"),
              hintText: "Tu E-mail",
              onChanged: (value) {
                this.email = value;
              },
            ),
            Text("E-mail invalido", textScaleFactor: 0.85, style: TextStyle(color: _ValidEmail ? Colors.white : Colors.red)),
            RoundedPasswordField(
              key: ValueKey("PW"),
              hintText: "Tu contraseña",
              onChanged: (value) {
                this.password = value;
              },
            ),
            Text("Contraseña invalida", textScaleFactor: 0.85, style: TextStyle(color: _ValidPassword ? Colors.white : Colors.red)),
            Container(
              child: isLoading ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kColorOrange)),
                  Text("Iniciando sesión")],
              ) :
            RoundedButton(
              text: "Iniciar sesión",
              key: ValueKey("Iniciar Sesion"),
              press: () async {
                if(ValidarCampos()) {
                  setState(() {
                    isLoading = true;
                  });
                  await UserService.login(email, password).then((value) => {
                    if(value != null) {
                      setState(() {
                        isLoading = false;
                      }),
                      showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: Text("Hubo un error!"),
                          content: Text(value),
                      )
                    )
                    }
                    else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {return MapPage();}))
                      .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      })
                    }
                  });
                }
              },
            )
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpPage();
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

  // ignore: non_constant_identifier_names
  bool ValidarCampos() {
    CleanValidator();
    if(!esEmailValido()){
      setState(() {
        _ValidEmail = false;
      });
      return false;
    }
    if(!esPasswordValido()){
      setState(() {
        _ValidPassword = false;
      });
      return false;
    }
    return true;
  }

  bool esEmailValido(){
    return this.email == null ? false : this.email.isNotEmpty;
  }

  bool esPasswordValido(){
    return this.password == null ? false : this.password.isNotEmpty;
  }

  void CleanValidator(){
    setState(() {
      _ValidEmail = true;
      _ValidPassword = true;
    });
  }

}



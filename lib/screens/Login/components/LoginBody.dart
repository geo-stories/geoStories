import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_stories/components/already_have_an_account_acheck.dart';
import 'package:geo_stories/components/rounded_button.dart';
import 'package:geo_stories/components/rounded_input_field.dart';
import 'package:geo_stories/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/Signup/signup_screen.dart';
import 'package:geo_stories/services/user_service.dart';

import '../../map_page.dart';
import 'background.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
              hintText: "Tu Email",
              onChanged: (value) {
                this.email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.password = value;
              },
            ),
            RoundedButton(
              text: "Iniciar sesión",
              press: () {
                UserService.login(email, password).then((UserCredential userCredential) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MapPage();
                        },
                      ),
                    );
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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

import 'package:flutter/material.dart';
import 'package:geo_stories/components/already_have_an_account_acheck.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/rounded_input_field.dart';
import 'package:geo_stories/components/Ui/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/login_page.dart';

import 'signup_background.dart';

class SignupBody extends StatelessWidget {

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
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Tu E-mail",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "Tu contraseña",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "Repetir contraseña",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Regístrate",
              press: () {},
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

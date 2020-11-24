import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/components/Welcome/welcome_background.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/screens/login_page.dart';
import 'package:geo_stories/services/user_service.dart';
import 'map_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/geostories-logo.svg",
              height: size.height * 0.36,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              key: ValueKey("Iniciar Sesion"),
              text: "Iniciar sesión",
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
            RoundedButton(
              text: "Ingresar como Anónimo",
              key: ValueKey("Ingresar como Anon"),
              color: Colors.black,
              textColor: Colors.white,
              press: () {
                UserService.disconnect();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapPage();
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

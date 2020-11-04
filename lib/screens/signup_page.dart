import 'package:flutter/material.dart';
import 'package:geo_stories/components/Signup/signup_background.dart';
import 'package:geo_stories/components/Signup/signup_body.dart';
import 'package:geo_stories/components/already_have_an_account_acheck.dart';
import 'package:geo_stories/components/Ui/rounded_button.dart';
import 'package:geo_stories/components/Ui/rounded_input_field.dart';
import 'package:geo_stories/components/Ui/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/login_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SignupBody()
    );
  }
}

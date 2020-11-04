import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/text_field_container.dart';
import 'package:geo_stories/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  PasswordFieldState createState() => PasswordFieldState();

  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

}

class PasswordFieldState extends State<RoundedPasswordField> {
  bool obscurePassword = true;

  _togglePasswordVisibility() {
    setState(() {
      this.obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: obscurePassword,
        onChanged: super.widget.onChanged,
        cursorColor: kColorOrange,
        decoration: InputDecoration(
          hintText: super.widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kColorOrange
          ),
          suffixIcon: IconButton(
            icon: Icon(
                obscurePassword
                ? Icons.visibility_off
                : Icons.visibility
            ),
            color: kColorOrange,
            onPressed: () {
              _togglePasswordVisibility();
            }
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

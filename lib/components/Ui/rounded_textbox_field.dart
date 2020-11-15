import 'package:flutter/material.dart';
import 'package:geo_stories/components/Ui/text_field_container.dart';
import 'package:geo_stories/constants.dart';

class RoundedTextboxField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedTextboxField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kColorOrange,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kColorOrange,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

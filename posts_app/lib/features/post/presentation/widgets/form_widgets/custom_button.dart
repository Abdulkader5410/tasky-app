import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme/app_theme.dart';

class CustomButton extends StatelessWidget {
final void Function() addOrUpdatePress;
final text;

  const CustomButton({super.key, required this.addOrUpdatePress, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: primaryColor,
        onPressed: () {
          addOrUpdatePress();
        },
        child:  Text(
          text,
          style: stylebody,
        ));
  }
}

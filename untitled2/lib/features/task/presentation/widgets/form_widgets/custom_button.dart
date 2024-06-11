import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
final void Function() addOrUpdatePress;
final text;

  const CustomButton({super.key, required this.addOrUpdatePress, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.deepPurple,
        onPressed: () {
          addOrUpdatePress();
        },
        child:  Text(
          text,
    
        ));
  }
}

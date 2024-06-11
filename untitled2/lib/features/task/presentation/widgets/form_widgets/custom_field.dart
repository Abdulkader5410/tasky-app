import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String name;
  final bool multiLines;
  final TextEditingController controller;

  const CustomField(
      {super.key,
      required this.name,
      required this.multiLines,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        maxLines: multiLines ? 6 : 1,
        minLines: multiLines ? 6 : 1,
        decoration: InputDecoration(hintText: name),
        validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
      ),
    );
  }
}

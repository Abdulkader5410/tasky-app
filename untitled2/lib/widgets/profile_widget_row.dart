import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isPhone;

  RowWidget({
    super.key,
    required this.title,
    required this.content,
    required this.isPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 237, 237, 237).withOpacity(0.5)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          subtitle: Text(
            content,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: isPhone
              ? Icon(
                  Icons.copy,
                  color: Colors.deepPurple,
                )
              : null,
        ));
  }
}

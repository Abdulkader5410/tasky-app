import 'package:flutter/material.dart';
import 'package:flutter_fire_1/main.dart';



showLoading(context){
  return showDialog(context: context, builder: (context) {
    
    return const CircularProgressIndicator(color: tealColor,);

  },);
}
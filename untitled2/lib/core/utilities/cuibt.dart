import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pass extends Cubit<bool> {
  Pass() : super(false);

  void togglePass() {
    emit(!state);
  }
}

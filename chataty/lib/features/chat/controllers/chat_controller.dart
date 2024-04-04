import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatController extends StateNotifier<bool> {
  ChatController() : super(false);

  void change(String text) {
    if(text.isEmpty){
      state = false;
    }
    else{
      state=true;
    }
  }
}

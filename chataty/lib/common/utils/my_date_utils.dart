import 'package:flutter/material.dart';

class MyDateUtils {
  String getLastAcvtiveTime(
      {required BuildContext context, required int lastActive}) {

    final int i = int.tryParse("$lastActive") ?? -1;
    
    if (i == -1) return "last seen not available";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattTime = TimeOfDay.fromDateTime(time).format(context);


    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return "last seen today $formattTime";
    }
    if ((now.difference(time).inHours / 24).round() == 1) {
      return "last seen yesterday $formattTime";
    }
    String month = _getMonth(time);
    return "last seen on $month at $formattTime";
  }

  String _getMonth(DateTime dateTime) {
    switch (dateTime.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Spet';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'NA';
    }
  }
}

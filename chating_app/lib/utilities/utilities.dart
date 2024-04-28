import 'package:flutter/material.dart';

class Utilities {
  static String getLastActiveTimeOfUser(
      BuildContext context, String lastActive) {
    final i = int.tryParse(lastActive) ?? -1;

    if (i == 1) return "Last seen not available";

    final time = DateTime.fromMillisecondsSinceEpoch(i);
    final DateTime now = DateTime.now();
    final formattedTime = TimeOfDay.fromDateTime(time).format(context);

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return "Last seen on $formattedTime";
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return "Last seen yesterday at $formattedTime";
    }

    String month = getNameOfMonth(time);
    return "Last seen on ${time.day} $month on $formattedTime";
  }

  static String getLastTimeOfMsg(BuildContext context, String time) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);

    if (sent.day == now.day &&
        sent.month == now.month &&
        sent.year == now.year) {
      return formattedTime;
    }
    return sent.year == now.year
        ? '$formattedTime - ${sent.day} ${getNameOfMonth(sent)}'
        : '$formattedTime - ${sent.day} ${getNameOfMonth(sent)} ${sent.year}';
  }

  static String getNameOfMonth(DateTime date) {
    switch (date.month) {
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
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }

  static String getTimeOfMsg(BuildContext context, String time) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if (sent.day == now.day &&
        sent.month == now.month &&
        sent.year == now.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return "${sent.day} ${getNameOfMonth(sent)}";
  }
}

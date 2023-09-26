

import 'package:intl/intl.dart';

class Formats{
  static DateTime parseTimes(String dateTime){
    // return DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(dateTime);
  }

  static String parse1(DateTime dt){
    return DateFormat("dd MMM yyyy").format(dt);
  }

  static String parse2(DateTime dt){
    return DateFormat("dd MMM yyyy HH:mm").format(dt);
  }

  static String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return "${DateFormat("yyyy-MM-ddTHH:mm:ss").format(date)}-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}";
    }else {
      return "${DateFormat("yyyy-MM-ddTHH:mm:ss").format(date)}+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}";
    }
  }

  static String formatZ(DateTime dt){
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(dt);
  }
}
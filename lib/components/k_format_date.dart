import 'package:intl/intl.dart';

class KFormatDate {
  static String getDateUs({required String date, required bool time}) {
    String pattern = 'yyyy-MM-dd ${time ? "HH:mm" : ""}'.trim();
    // Hours on time zone
    int inHours = DateTime.parse(date).timeZoneOffset.inHours;
    DateTime d = DateTime.parse(date);
    // Change time zone
    String newDate =
        "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${(d.hour + inHours).toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.millisecond.toString().padLeft(2, '0')}";

    DateTime dateTime = DateTime.parse(newDate).toLocal();

    String result = DateFormat(pattern).format(dateTime);
    return result;
  }

  static String getDateThai({required String date, required bool time}) {
    String pattern = 'yyyy-MM-dd ${time ? "HH:mm" : ""}'.trim();

    DateTime dateTime = DateTime.parse(date).toLocal();

    String result = DateFormat(pattern).format(dateTime);
    return result;
  }
}

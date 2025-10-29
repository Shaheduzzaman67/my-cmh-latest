import 'package:intl/intl.dart';

class DateTimeUtils {
  static String extractTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      DateTime localDateTime = dateTime.toLocal();

      String formattedTime = DateFormat('HH:mm a').format(localDateTime);
      return formattedTime;
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  static String extractDate(String dateTimeString) {
    if (dateTimeString.isEmpty) {
      return '';
    }
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      DateTime localDateTime = dateTime.toLocal();

      String formattedDate = DateFormat('dd MMMM yyyy').format(localDateTime);
      return formattedDate;
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  static bool isSameDate(String dateStr1, String dateStr2) {
    if (dateStr1.isEmpty || dateStr2.isEmpty) {
      return false;
    }
    try {
      final d1 = dateStr1.substring(0, 10);
      final d2 = dateStr2.substring(0, 10);

      return d1 == d2;
    } catch (e) {
      return false; // Handle invalid date format gracefully
    }
  }
}

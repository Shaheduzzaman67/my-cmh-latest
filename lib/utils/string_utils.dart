import 'dart:convert';

class StringUtil {
  static String sanitize(String? input) {
    return input?.replaceAll(RegExp(r'[\r\n]+'), ' ') ?? '';
  }

  static String mobileNumberSanitize(String? input) {
    return input?.replaceAll(RegExp(r'[\r\n]+'), '') ?? '';
  }

  static String transformUsername(String userID) {
    userID = userID.toUpperCase();

    // Remove all spaces
    userID = userID.replaceAll(' ', '');

    if (userID.contains('/')) {
      return userID.replaceAll('/', '-');
    }

    if (userID.contains('BN-')) {
      return userID.replaceFirst(RegExp(r'BN-\d+'), userID.split('BN-').last);
    }

    // If it matches a pattern: letters followed by numbers (like BA123456)
    final match = RegExp(r'^([A-Z]+)(\d+)$').firstMatch(userID);
    if (match != null) {
      // Insert hyphen between letters and numbers
      return '${match.group(1)}-${match.group(2)}';
    }

    return userID;
  }

  static Map<String, dynamic> parseBusinessSchedule(String businessSchedule) {
    return jsonDecode(businessSchedule)['activeDays'];
  }
}

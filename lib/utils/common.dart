
import 'package:shared_preferences/shared_preferences.dart';

class TimeEntryTypeConstraints {
  static const String timeIn = "timein";
  static const String timeOut = "timeout";
  static const String crossOverDay = "crossoverday";
}

class URL{
  static const String url = "http://activeempl.contata.co.in";
}

class TimeEntry{
  static Future<void> saveTimeEntry(String entryType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(entryType, true);
  }

  Future<bool> retrieveTimeEntry(String entryType) async {
    final prefs = await SharedPreferences.getInstance();
    final value =
        prefs.getBool(entryType) ?? false;
    return value;
  }
}

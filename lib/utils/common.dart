
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeEntryTypeConstraints {
  static const String timeIn = "timein";
  static const String timeOut = "timeout";
  static const String crossOverDay = "crossoverday";
  static const String entryTimeIn = "entrytimein";
  static const String entryTimeOut = "entrytimeout";
  static const String entryTimeCrossOverDay = "entrycrossoverday";
}

class URL{
  static const String url = "http://activeempl.contata.co.in";
}

class TimeEntry{
  static Future<void> saveTimeEntry(String entryType,String entryTime) async {
    final prefs = await SharedPreferences.getInstance();
    String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    await prefs.setBool(entryType, true);
    await prefs.setString(entryTime, currentTime);
  }

  Future<bool> retrieveTimeEntry(String entryType) async {
    final prefs = await SharedPreferences.getInstance();
    final value =
        prefs.getBool(entryType) ?? false;
    return value;
  }
}

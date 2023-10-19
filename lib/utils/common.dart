import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginKeys {
  static const String username = "username";
  static const String keylogin = "isLogin";
}

class TimeEntryTypeConstraints {
  static const String timeIn = "timein";
  static const String timeOut = "timeout";
  static const String crossOverDay = "crossoverday";
  static const String entryHistory = "entryhistory";
  static const String entryTimeInDate = "entrytimeindate";
  static const String entryTimeOutDate = "entrytimeoutdate";
  static const String entryTimeCrossOverDayDate = "entrycrossoverdaydate";
  static const String entryTimeIn = "entrytimein";
  static const String entryTimeOut = "entrytimeout";
  static const String entryTimeCrossOverDay = "entrycrossoverday";
}

class URL {
  static const String url = "http://activeempl.contata.co.in";
}

class UserDetails {}

class TimeEntry {
  static Future<void> saveTimeEntry(
      String entryType, String entryTime, String entryDate) async {
    final prefs = await SharedPreferences.getInstance();
    String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    //String currentDate = DateFormat.yMd().format(DateTime.now());
    final currentDate = DateTime.now();
    final currentDateWithoutTime = DateTime(currentDate.year, currentDate.month, currentDate.day).toIso8601String();
    await prefs.setBool(entryType, true);
    await prefs.setString(entryTime, currentTime);
    await prefs.setString(entryDate, currentDateWithoutTime);
  }

  static Future<void> saveUserDetails(bool isCrossOver) async {
    final prefs = await SharedPreferences.getInstance();
    //String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    await prefs.setBool(TimeEntryTypeConstraints.crossOverDay, isCrossOver);
  }

  Future<bool> retrieveTimeEntry(String entryType) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(entryType) ?? false;
    return value;
  }

  static void clearTimeEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(TimeEntryTypeConstraints.timeIn);
    prefs.remove(TimeEntryTypeConstraints.entryTimeIn);
    prefs.remove(TimeEntryTypeConstraints.entryTimeInDate);
    prefs.remove(TimeEntryTypeConstraints.timeOut);
    prefs.remove(TimeEntryTypeConstraints.entryTimeOut);
    prefs.remove(TimeEntryTypeConstraints.entryTimeOutDate);
    prefs.remove(TimeEntryTypeConstraints.crossOverDay);
  }
}

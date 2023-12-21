import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pengguna.dart';

class UserPreferences {
  static const String _key = 'user';

  static Future<void> saveUser(Pengguna user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userJson = jsonEncode(user.toMap());
    prefs.setString(_key, userJson);
  }

  static Future<Pengguna?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_key);

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return Pengguna.fromMap(userMap);
    } else {
      return null;
    }
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}

class DateShiftPreferences {
  static const String _keyDate = 'date';
  static const String _keyShift = 'shift';

  static Future<void> saveDateShift(DateTime date, int shift) async {
    final SharedPreferences dateShiftPref =
        await SharedPreferences.getInstance();
    String tanggal = date.toString();
    dateShiftPref.setString(_keyDate, tanggal);
    dateShiftPref.setInt(_keyShift, shift);
  }

  static Future<int> getShift() async {
    final SharedPreferences dateShiftPref =
        await SharedPreferences.getInstance();
    int? savedShift = dateShiftPref.getInt(_keyShift);
    int indexShift = savedShift ?? 0;
    return indexShift;
  }

  static Future<String> getDate() async {
    final SharedPreferences dateShiftPref =
        await SharedPreferences.getInstance();
    String? savedDate = dateShiftPref.getString(_keyDate);
    String dateWaktu = savedDate ?? DateTime.now.toString();
    return dateWaktu;
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyDate);
    prefs.remove(_keyShift);
  }
}

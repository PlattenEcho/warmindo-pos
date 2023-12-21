import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pengguna.dart';

class UserPreferences {
  static const String _key = 'user';

  // Fungsi untuk menyimpan informasi pengguna ke SharedPreferences
  static Future<void> saveUser(Pengguna user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userJson = jsonEncode(user.toMap());
    prefs.setString(_key, userJson);
  }

  // Fungsi untuk mendapatkan informasi pengguna dari SharedPreferences
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

  // Fungsi untuk menghapus informasi pengguna dari SharedPreferences
  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}

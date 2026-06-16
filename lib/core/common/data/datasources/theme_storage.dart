import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  ThemeStorage._();
  static final String _key = 'theme';

  static Future<void> saveTheme(ThemeMode mode) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString(_key, mode == .dark ? "dark" : "light");
  }

  static Future<bool> isDark() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_key) == "dark";
  }
}

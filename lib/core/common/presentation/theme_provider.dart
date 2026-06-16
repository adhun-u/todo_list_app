import 'package:flutter/material.dart';
import 'package:todo_list/core/common/data/datasources/theme_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = .light;

  ThemeMode get currentTheme => _currentTheme;

  ThemeProvider() {
    _retrieveSavedTheme();
  }

  void _retrieveSavedTheme() async {
    final isDark = await ThemeStorage.isDark();

    if (isDark) {
      _currentTheme = .dark;
    } else {
      _currentTheme = .light;
    }

    notifyListeners();
  }

  void changeTheme() {
    if (_currentTheme == .light) {
      _currentTheme = .dark;
    } else {
      _currentTheme = .light;
    }
    notifyListeners();

    ThemeStorage.saveTheme(_currentTheme);
  }
}

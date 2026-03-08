import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final Box _box = Hive.box('settings'); // Settings ke liye naya box

  ThemeProvider() {
    // App start hotay hi purani theme load karega
    _isDarkMode = _box.get('isDarkMode', defaultValue: false);
  }

  bool get isDarkMode => _isDarkMode;

  // Flutter ko batane ke liye ke konsa mode lagana hai
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Theme change  function
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _box.put('isDarkMode', _isDarkMode); // Save in Hive
    notifyListeners();
  }
}

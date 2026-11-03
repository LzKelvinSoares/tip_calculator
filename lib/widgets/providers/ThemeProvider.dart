import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;
  IconData get themeIcon => _currentTheme == ThemeMode.light ? Icons.nightlight_round : Icons.wb_sunny;

  ThemeData get currentTheme {
    if (_currentTheme == ThemeMode.light) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
    } else {
      return ThemeData.dark(useMaterial3: true);
    }
  }
  
  void toggleTheme() {
    if (_currentTheme == ThemeMode.light) {
      _currentTheme = ThemeMode.dark;
    } else {
      _currentTheme = ThemeMode.light;
    }
    notifyListeners();
  }
}
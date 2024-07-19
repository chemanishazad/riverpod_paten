import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void toggleTheme(bool isDarkMode) {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) => ThemeProvider());

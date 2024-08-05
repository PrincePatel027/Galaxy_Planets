import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String? defaultThemeMode = "Light";

  toggleThemeMode(String theme) {
    defaultThemeMode = theme;
    log(defaultThemeMode.toString());
    notifyListeners();
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("THEME", defaultThemeMode!);
    notifyListeners();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("THEME") != null) {
      defaultThemeMode = prefs.getString("THEME");
    }
  }
}

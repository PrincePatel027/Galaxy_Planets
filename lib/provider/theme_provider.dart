import 'dart:developer';

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String defaultThemeMode = "Light";

  toggleThemeMode(String theme) {
    defaultThemeMode = theme;
    log(defaultThemeMode.toString());
    notifyListeners();
  }
}

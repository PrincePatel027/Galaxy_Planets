import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeProvider extends ChangeNotifier {
  bool isLiked = false;
  List likedData = [];

  LikeProvider() {
    loadData();
  }

  toogleLike(Map data) {
    isLiked = !isLiked;
    (isLiked) ? addData(data) : removeData(data);
    log(likedData.toString());
    saveData();
    notifyListeners();
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(likedData);
    await prefs.setString("LIKED", encodedData);
    notifyListeners();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("LIKED");
    if (data != null) {
      likedData = jsonDecode(data);
    }
    notifyListeners();
  }

  addData(Map data) {
    likedData.add(data);
    notifyListeners();
  }

  removeData(Map data) {
    likedData.remove(data);
    notifyListeners();
  }
}

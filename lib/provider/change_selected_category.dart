import 'package:flutter/material.dart';

class ChangeSelectedCategory with ChangeNotifier {
  String selectedValue = "Education";

  void changeCategory(String value) {
    selectedValue = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class SelectedDateProvider with ChangeNotifier {
  final String currentDate = DateTime.now().year.toString();
}

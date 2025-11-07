import 'package:flutter/material.dart';

class UserStateProvider extends ChangeNotifier {
  String _name = '';

  String get name => _name;

  void setName(String newName) {
    _name = newName;
    notifyListeners(); // for UI updates
  }

  void reset() {
    _name = '';
    notifyListeners();
  }
}
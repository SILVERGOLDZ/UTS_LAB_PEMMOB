import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserStateProvider extends ChangeNotifier {
  String _name = '';
  int _score = 0;

  String get name => _name;
  int get score => _score;

  void setName(String newName) {
    _name = newName;
    notifyListeners(); // for UI updates
  }

  void setScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void reset() {
    _name = '';
    _score = 0;
    notifyListeners();
  }
}
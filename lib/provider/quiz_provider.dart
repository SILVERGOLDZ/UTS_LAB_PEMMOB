import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  Map<String, dynamic>? _scoreData;
  int _total = 0;

  Map<String, dynamic>? get scoreData => _scoreData;
  int get total => _total;

  void setScoreData(Map<String, dynamic> data) {
    _scoreData = data;
    notifyListeners();
  }
  void setTotal(int data) {
    _total = data;
    notifyListeners();
  }

  void clearScoreData() {
    _scoreData = null;
    notifyListeners();
  }
}
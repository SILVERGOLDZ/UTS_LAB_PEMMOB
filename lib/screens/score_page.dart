import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final Map<String, int>? scoreData;

  const ScorePage({super.key, this.scoreData});

  @override
  Widget build(BuildContext context) {
    int score = scoreData?['score'] ?? 0;
    int total = scoreData?['total'] ?? 0;

    return Scaffold(
      body: Center(
        child: Text('Your score: $score / $total'),
      ),
    );
  }
}
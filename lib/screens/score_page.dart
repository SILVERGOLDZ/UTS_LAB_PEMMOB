import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class ScorePage extends StatelessWidget {
  final Map<String, int>? scoreData;

  const ScorePage({super.key, this.scoreData});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserStateProvider>(context);

    int score = scoreData?['score'] ?? 0;
    int total = scoreData?['total'] ?? 0;

    return SafeArea(
      top: true,
      child: Center(
        child: Column(
            children: [
              Text(
                user.name,
                style: const TextStyle(fontSize: 20),
              ),
              Text('Your score: $score / $total'),
            ],
        ),
      ),
    );
  }
}
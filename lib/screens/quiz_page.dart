import 'package:anime_verse/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/quiz_card_widget.dart';
import '/data/dummy.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Store selected answers for each question (using question index as key)
  Map<int, int> selectedAnswers = {};

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < DummyData.pertanyaan.length; i++) {
      // Compare selected answer with correct answer
      if (selectedAnswers[i] == DummyData.pertanyaan[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        final String currentLocation = GoRouterState.of(context).uri.path;

        if (currentLocation == '/quiz') {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit Quiz'),
              content: const Text(
                  'Are you sure you want to quit Quiz session? (Your progress will not be saved!)'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            GoRouter.of(context).go('/home');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              for (var i = 0; i < DummyData.pertanyaan.length; i++)
                CardWidget(
                  question: DummyData.pertanyaan[i].soal,
                  answer: DummyData.pertanyaan[i].opsi,
                  selectedIndex: selectedAnswers[i],
                  onAnswerSelected: (answerIndex) {
                    setState(() {
                      selectedAnswers[i] = answerIndex;
                    });
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  if (selectedAnswers.length == DummyData.pertanyaan.length) {
                    int score = calculateScore();
                    int totalQuestions = DummyData.pertanyaan.length;

                    // Pass score to the score page
                    context.go(
                      "/score",
                      extra: {
                        'score': score,
                        'total': totalQuestions,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please answer all questions'),
                      ),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
import 'package:anime_verse/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/quiz_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/quiz_card_widget.dart';
import '/data/dummy.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<int, int> selectedAnswers = {};
  int currentQuestionIndex = 0;

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < DummyData.pertanyaan.length; i++) {
      if (selectedAnswers[i] == DummyData.pertanyaan[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  void nextQuestion() {
    if (currentQuestionIndex < DummyData.pertanyaan.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = DummyData.pertanyaan;

    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Quiz'),
            content: const Text(
                'Are you sure you want to quit the quiz? Your progress will not be saved.'),
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
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDark
                    ? 'assets/images/DarkBG.jpg' // dark mode background
                    : 'assets/images/SoothingBG.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // number display
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(questions.length, (index) {
                        bool isCurrent = index == currentQuestionIndex;
                        bool isAnswered = selectedAnswers[index] != null;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentQuestionIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCurrent
                                  ? Colors.blueAccent
                                  : (isAnswered
                                  ? Colors.greenAccent.withOpacity(0.7)
                                  : Colors.white.withOpacity(0.3)),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Current card
                  Expanded(
                    child: Center(
                      child: CardWidget(
                        question: questions[currentQuestionIndex].soal,
                        answer: questions[currentQuestionIndex].opsi,
                        selectedIndex: selectedAnswers[currentQuestionIndex],
                        onAnswerSelected: (answerIndex) {
                          setState(() {
                            selectedAnswers[currentQuestionIndex] = answerIndex;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: previousQuestion,
                        child: const Text('Previous'),
                      ),
                      if (currentQuestionIndex < questions.length - 1)
                        ElevatedButton(
                          onPressed: nextQuestion,
                          child: const Text('Next'),
                        )
                      else
                        ElevatedButton(
                          onPressed: () {
                            int score = calculateScore();
                            int totalQuestions = questions.length;

                            Provider.of<QuizProvider>(context, listen: false).setScoreData({
                              'score': score,
                              'total': totalQuestions,
                              'answers': selectedAnswers,
                            });
                            context.go('/score');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: const Text('Submit'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
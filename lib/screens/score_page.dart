import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/user_provider.dart';
import '/data/dummy.dart';

class ScorePage extends StatefulWidget {
  final Map<String, dynamic>? scoreData;

  const ScorePage({super.key, this.scoreData});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserStateProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = (screenWidth < screenHeight ? screenWidth : screenHeight);

    if (widget.scoreData == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/SoothingBG.jpg'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: screenSize * 0.2,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                Text(
                  'No quiz results available',
                  style: TextStyle(
                    fontSize: screenSize * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please complete the quiz first',
                  style: TextStyle(
                    fontSize: screenSize * 0.03,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final int score = widget.scoreData!['score'] ?? 0;
    final int total = widget.scoreData!['total'] ?? 0;
    final Map<int, int> selectedAnswers =
    Map<int, int>.from(widget.scoreData!['answers'] ?? {});

    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                ? 'assets/images/DarkBG.jpg'   // dark mode background
                : 'assets/images/Soothing'
                  'BG.jpg',),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight *0.4),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You score: $score / $total",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              // show results each question
              for (var i = 0; i < DummyData.pertanyaan.length; i++)
                _buildResultCard(
                  DummyData.pertanyaan[i].soal,
                  DummyData.pertanyaan[i].opsi,
                  DummyData.pertanyaan[i].correctAnswerIndex,
                  selectedAnswers[i],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(
      String question, List<String> answers, int correctIndex, int? selectedIndex) {
    bool isCorrect = selectedIndex == correctIndex;


    final Color baseColor =
    isCorrect ? Colors.greenAccent : Colors.redAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: baseColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: baseColor.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    for (var j = 0; j < answers.length; j++)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: j == correctIndex
                              ? Colors.green.withOpacity(0.4)
                              : j == selectedIndex
                              ? Colors.red.withOpacity(0.4)
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          answers[j],
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
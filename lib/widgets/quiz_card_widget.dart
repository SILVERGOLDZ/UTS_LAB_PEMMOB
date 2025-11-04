import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String question;
  final List<String> answer;
  final int? selectedIndex;
  final Function(int) onAnswerSelected;

  const CardWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.selectedIndex,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Color(0xFFdedede),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                for (var i = 0; i < answer.length; i++)
                  GestureDetector(
                    onTap: () {
                      onAnswerSelected(i);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Card.filled(
                        color: selectedIndex == i ? Colors.white : Color(0xFFdedede),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            answer[i],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
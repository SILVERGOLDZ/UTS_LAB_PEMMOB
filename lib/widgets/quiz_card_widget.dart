

import 'package:flutter/material.dart';

import '../model/quiz_list.dart';

class CardWidget extends StatelessWidget{
  final String question;
  final List<String> answer;

  const CardWidget({
    super.key,
    required this.question,
    required this.answer,
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
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                for (var opsi in answer)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20), // space top & bottom
                    child: Text(
                      opsi,
                      style: TextStyle(
                        fontSize: 20
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
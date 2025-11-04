import 'package:anime_verse/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/quiz_card_widget.dart';
import '/data/dummy.dart';
import '/model/quiz_list.dart';
import '/config/routes.dart';

class QuizPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            for (var pertanyaans in DummyData.pertanyaan)
              CardWidget(
                  question: pertanyaans.soal,
                  answer: pertanyaans.opsi,
              ),
            ElevatedButton(
                onPressed: () => context.goNamed("score"),
                child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
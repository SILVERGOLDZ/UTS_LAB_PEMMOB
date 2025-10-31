import 'package:flutter/material.dart';


class QuizPage extends StatefulWidget{
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() =>  _HomePageState();
}

class  _HomePageState extends State<QuizPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ini Quiz Page'),
      ),
    );
    throw UnimplementedError();
  }
}

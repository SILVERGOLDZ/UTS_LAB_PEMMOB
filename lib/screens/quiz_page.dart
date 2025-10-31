import 'package:flutter/material.dart';
import '/provider/user_provider.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatelessWidget{
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(title: const Text('Persistent Form')),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       TextField(
      //         decoration: const InputDecoration(labelText: 'Name'),
      //         onChanged: (value) => formData.updateName(value),
      //         controller: TextEditingController(text: formData.name),
      //       ),
      //       TextField(
      //         decoration: const InputDecoration(labelText: 'Email'),
      //         onChanged: (value) => formData.updateEmail(value),
      //         controller: TextEditingController(text: formData.email),
      //       ),
      //       const SizedBox(height: 20),
      //       Text('Current Name: ${formData.name}'),
      //       Text('Current Email: ${formData.email}'),
      //     ],
      //   ),
      // ),
    );
  }
}
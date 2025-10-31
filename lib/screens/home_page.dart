import 'package:anime_verse/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/config/routes.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserStateProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: user.setName,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Start the quiz
                context.goNamed('quiz');
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}

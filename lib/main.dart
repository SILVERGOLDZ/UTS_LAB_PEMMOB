import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'package:provider/provider.dart';
import '/provider/user_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserStateProvider(),
        child: MaterialApp.router(
          title: 'quizApp',
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(),
          ),
          themeMode: ThemeMode.dark,
          routerConfig: createRouter(),
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}
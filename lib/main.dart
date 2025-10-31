import 'package:flutter/material.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'AnimeVerse',
        themeMode: ThemeMode.dark,
        routerConfig: createRouter(),
        debugShowCheckedModeBanner: false,
    );
  }
}
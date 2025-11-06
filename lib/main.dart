import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import '/provider/user_provider.dart';
import '/provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserStateProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            title: 'QuizApp',
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light(),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(),
            ),
            themeMode: themeProvider.themeMode,
            routerConfig: createRouter(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

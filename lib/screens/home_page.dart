import 'package:anime_verse/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../provider/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserStateProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = (screenWidth < screenHeight ? screenWidth : screenHeight);

    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                isDark
                    ? 'assets/images/DarkBG.jpg'
                    : 'assets/images/SoothingBG.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Before we start, Please enter your name',
                    style: TextStyle(
                      fontSize: screenSize * 0.03,
                      fontFamily: 'Aloevera',
                      color:
                        isDark ? Colors.white : Colors.black87,

                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth > 600 ? 550 : double.infinity,
                      ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'My name is ...',
                        labelStyle: TextStyle(
                          color: Color(0x80484848),
                        ),
                        filled: true,
                        fillColor: Color(0xffe5e5e5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onChanged: user.setName,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('quiz');
                    },
                    child: const Text('I am Ready!'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

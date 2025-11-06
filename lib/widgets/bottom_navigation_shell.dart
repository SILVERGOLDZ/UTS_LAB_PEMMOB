import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';

class BottomNavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationShell({super.key, required this.navigationShell});

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final currentIndex = navigationShell.currentIndex;
    final bool isMobile = screenWidth < 600;


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        final String currentLocation = GoRouterState.of(context).uri.path;

        if (currentLocation == AppRoutes.home) {
          // Show exit confirmation dialog
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );

          // Exit app if user confirmed
          if (shouldExit == true) {
            SystemNavigator.pop();
          }
        } else {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          } else {
            context.go(AppRoutes.home);
          }
        }
      },

      child: SafeArea(
        top: false,
        child: Scaffold(
          body: navigationShell,
          extendBody: true,
          bottomNavigationBar: isMobile
          ? Container(
            decoration: const BoxDecoration(
              color: Color(0xFF702e46),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  0,
                  Icons.home_rounded,
                  'Home',
                  currentIndex,
                  screenWidth,
                  screenHeight,
                ),
                _buildNavItem(
                  context,
                  1,
                  Icons.grading,
                  'Score',
                  currentIndex,
                  screenWidth,
                  screenHeight,
                ),
              ],
            ),
          )
              : null
        ),
      ),

    );
  }

  Widget _buildNavItem(
      BuildContext context,
      int index,
      IconData icon,
      String label,
      int currentIndex,
      double screenWidth,
      double screenHeight,
      ) {
    final isActive = index == currentIndex;

    return isActive
        ? GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.025,
          horizontal: screenWidth * 0.045,
        ),
        decoration: BoxDecoration(
            color: const Color(0xffa64267),
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: screenWidth * 0.02,
                offset: Offset(0, screenHeight * 0.005),
              ),
            ]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: screenWidth * 0.06,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ],
        ),
      ),
    )
        : GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Icon(
          icon,
          color: Colors.grey.shade600,
          size: screenWidth * 0.06,
        ),
      ),
    );
  }

}
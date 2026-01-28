import 'package:flutter/material.dart';
import 'dart:ui'; // Required for Glassmorphism
import 'package:my_portfolio/about_screen.dart';
import 'package:my_portfolio/contact_screen.dart';
// Only use one import for the Home Screen to avoid conflicts
import 'package:my_portfolio/home_screen.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/projectsscreen.dart';
import 'package:my_portfolio/skills_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List of screens
  final List<Widget> _screens = const [
    HomeScreen(),
    AboutScreen(),
    SkillsScreen(),
    ProjectsScreen(),
    ContactScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to flow behind the glass bar
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.02, 0), // Subtle slide
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: _buildGlassBottomBar(),
    );
  }

  Widget _buildGlassBottomBar() {
    // ✅ Listen to the same themeNotifier used in main.dart and home_screen.dart
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;

        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: 70,
          decoration: BoxDecoration(
            // ✅ Change color based on theme: Darker in Light mode for contrast
            color:
                isDark
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFF1E293B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              if (!isDark) // Soft shadow only for light mode
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                // ✅ Signature Blue for active, Grey/Slate for inactive
                selectedItemColor: const Color(0xFF6366F1),
                unselectedItemColor:
                    isDark ? Colors.white38 : const Color(0xFF64748B),
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedFontSize: 12,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: "About",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bolt_outlined),
                    activeIcon: Icon(Icons.bolt),
                    label: "Skills",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.rocket_launch_outlined),
                    activeIcon: Icon(Icons.rocket_launch),
                    label: "Projects",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.alternate_email),
                    activeIcon: Icon(Icons.alternate_email),
                    label: "Contact",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/home_screen.dart';
import 'package:my_portfolio/login_screen.dart';
import 'package:my_portfolio/presentation/screens/main_navigation.dart';
import 'package:my_portfolio/services/auth_service.dart';
import 'package:my_portfolio/splash_screen.dart'; // ✅ Added this import
import 'package:shared_preferences/shared_preferences.dart';

late ValueNotifier<ThemeMode> themeNotifier;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isDark = prefs.getBool('isDarkMode') ?? true;

  themeNotifier = ValueNotifier(isDark ? ThemeMode.dark : ThemeMode.light);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBkaP9w0xlTevSTtfCNNzJzVGIQllY7mjY",
      appId: "1:561899526108:android:6d6a41120df9e657b32119",
      messagingSenderId: "561899526108",
      projectId: "quizzo-firebase-store",
      storageBucket: "quizzo-firebase-store.firebasestorage.app",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kunal Sonawane Portfolio',

          theme: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF3B82F6),
            scaffoldBackgroundColor: const Color.fromARGB(255, 115, 131, 146),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3B82F6),
              surface: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),

          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.blueAccent,
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueAccent,
              surface: Color(0xFF1E293B),
            ),
          ),

          themeMode: currentMode,

          // ✅ Updated: Start at SplashScreen to bypass login check
          home: const SplashScreen(),

          /* // Keep this here in case you want to restore login in the future:
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.hasData) {
                return const MainNavigation();
              }
              return const LoginScreen();
            },
          ),
          */
        );
      },
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wroom_application/features/auth/pages/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 122.69,
          width: 205.61,
          child: Image.asset("assets/images/wroom.png", fit: BoxFit.cover),
        ),
      ),
    );
  }
}

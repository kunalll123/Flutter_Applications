import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb or defaultTargetPlatform
import 'package:wroom_application/features/auth/pages/signup_screen.dart';
import 'package:wroom_application/features/auth/pages/splash_screen.dart';
import 'package:wroom_application/features/stations/addvehicle_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // MANUAL FIREBASE INITIALIZATION
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDGGBj6yfJP8BSGENeS2DhGb2r7u7ao0uk',
      appId:
          '1:334697905875:android:ecac29388686318b4b1e26', // Format: 1:123456789:android:abc123def
      messagingSenderId: '334697905875',
      projectId: 'add-cart-page',
      storageBucket: 'add-cart-page.firebasestorage.app',
      iosBundleId: 'com.your.bundle.id', // Required for iOS
    ),
  );

  runApp(const EVCarApp());
}

class EVCarApp extends StatelessWidget {
  const EVCarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WROOM EV',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // home: const AddEVVehicleScreen(),
    );
  }
}

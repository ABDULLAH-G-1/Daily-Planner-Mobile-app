import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 seconds ke baad Home Screen par move kar jayega
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Neon logo ke liye professional dark background
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image: Path updated as per your actual location
            Image.asset(
              'assets/images/logo.png',
              width: 160, // Thora sa size barha diya hai taake clear nazar aaye
              fit: BoxConstraints().maxWidth < 600 ? BoxFit.contain : BoxFit.scaleDown,
            ),

            const SizedBox(height: 25), // Logo aur Text ke darmiyan munasib gap

            // App Name: Logo ke bilkul neeche show hoga
            const Text(
              "Daily Planner",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
                fontFamily: 'sans-serif', // Default clean font
              ),
            ),

            const SizedBox(height: 10),

            // Optional: Chota sa subtitle professional look ke liye
            Text(
              "Organize Your Day",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
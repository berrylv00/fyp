import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'login_screen.dart';

import 'dart:ui';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );



    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

return Scaffold(
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff071224),
          Color(0xff15113A),
          Color(0xff0F1D35),
        ],
      ),
    ),
    child: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: 320,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 40,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white24,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                Image.asset(
  "assets/images/azhly_logo.png",
  width: 110,
  height: 110,

    
    
                ),
          const SizedBox(height: 20),

                  const Text(
                    "AZHly",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Smart Room Allocation System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.purple,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),
);
  }
}
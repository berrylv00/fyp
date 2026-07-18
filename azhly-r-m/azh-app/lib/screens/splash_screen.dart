import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [

              Color(0xff071A52),
              AppColors.darkBg,
              Color(0xff1E1060),

            ],
          ),
        ),

        child: Center(

          child: FadeTransition(

            opacity: _fadeAnimation,

            child: ScaleTransition(

              scale: _scaleAnimation,

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withValues(alpha: 0.45),
                          blurRadius: 45,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/azhly_logo.png",
                      width: 170,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "AZHly",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Smart Scheduling • Smarter Spaces",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .78),
                      fontSize: 13,
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        minHeight: 4,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
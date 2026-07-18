import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const AzhlyApp());

class AzhlyApp extends StatefulWidget {
  const AzhlyApp({super.key});

  @override
  State<AzhlyApp> createState() => _AzhlyAppState();
}

class _AzhlyAppState extends State<AzhlyApp> {
  // Wire this up to your theme-toggle screen / settings provider.
  ThemeMode _themeMode = ThemeMode.dark;

  void setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AZHly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      // No splash/bubble screen — app opens, waits 1 second, then goes
      // straight to Login. From there: Login -> Register (if needed) ->
      // Login -> Role select (Teacher / CR-GR / Student) -> Dashboard.
      home: const SplashScreen(),
    );
  }
}

/// Plain 1-second gate shown on app launch — just the scaffold background,
/// no bubble artwork, no logo animation. After 1 second it swaps itself
/// out for LoginScreen.
class StartupGate extends StatefulWidget {
  const StartupGate({super.key});

  @override
  State<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<StartupGate> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Bare scaffold — intentionally no bubble background here.
    return const Scaffold(body: SizedBox.shrink());
  }
}

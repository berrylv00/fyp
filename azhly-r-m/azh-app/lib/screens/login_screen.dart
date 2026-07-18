import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';
import 'role_select_screen.dart';
import '../services/api_service.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService api = ApiService();

  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await api.login(
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );

      if (response["success"] == true) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"]),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RoleSelectScreen(
              userData: response,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"]),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error : $e"),
        ),
      );
    }
  }

  Future<void> _goToRegister() async {
    final newEmail = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
      ),
    );

    if (newEmail != null && mounted) {
      _emailCtrl.text = newEmail;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created — please login"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

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
            width: 370,
            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.08),

              borderRadius:
                  BorderRadius.circular(28),

              border: Border.all(
                color: Colors.white24,
              ),
            ),

            child: Form(
              key: _formKey,

              child: Column(
                children: [

                  const Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 70,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Login to your AZHly account",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _emailCtrl,
                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      labelText: "University Email",

                      labelStyle: const TextStyle(
                        color: Colors.white70,
                      ),

                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white70,
                      ),

                      filled: true,

                      fillColor:
                          Colors.white.withOpacity(.06),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    validator: (v) =>
                        v == null || v.isEmpty
                            ? "Required"
                            : null,
                  ),

                  const SizedBox(height: 18),

                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: true,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      labelText: "Password",

                      labelStyle: const TextStyle(
                        color: Colors.white70,
                      ),

                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white70,
                      ),

                      filled: true,

                      fillColor:
                          Colors.white.withOpacity(.06),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    validator: (v) =>
                        v == null || v.isEmpty
                            ? "Required"
                            : null,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: _login,

                      child: const Text(
                        "LOGIN",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: _goToRegister,

                    child: const Text(
                      "Create New Account",
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
),
    );
  }
}

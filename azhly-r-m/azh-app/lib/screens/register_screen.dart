import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dart:ui';

/// New-user registration. On success, pops back to LoginScreen with the
/// chosen username so the person can log in right away.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(_usernameCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
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

              borderRadius: BorderRadius.circular(28),

              border: Border.all(
                color: Colors.white24,
              ),
            ),

            child: Form(
              key: _formKey,

              child: Column(
                children: [

                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                    size: 70,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Join the AZHly Smart Room Allocation System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _nameCtrl,
                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      labelText: "Full Name",

                      labelStyle: const TextStyle(
                        color: Colors.white70,
                      ),

                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white70,
                      ),

                      filled: true,
                      fillColor: Colors.white.withOpacity(.06),

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

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _usernameCtrl,
                    style: const TextStyle(color: Colors.white),

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
                      fillColor: Colors.white.withOpacity(.06),

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

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),

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
                      fillColor: Colors.white.withOpacity(.06),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    validator: (v) =>
                        v == null || v.length < 4
                            ? "Minimum 4 characters"
                            : null,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmCtrl,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      labelText: "Confirm Password",

                      labelStyle: const TextStyle(
                        color: Colors.white70,
                      ),

                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white70,
                      ),

                      filled: true,
                      fillColor: Colors.white.withOpacity(.06),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    validator: (v) =>
                        v != _passwordCtrl.text
                            ? "Passwords do not match"
                            : null,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: _submit,

                      child: const Text(
                        "REGISTER",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context),

                    child: const Text(
                      "Already have an account? Login",
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

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
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [

AppColors.navy,
AppColors.darkBg,
AppColors.navy2,

],

),
),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AZHly",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Smart scheduling\nsmarter spaces",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: dimColor,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (v) => v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: dimColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _goToRegister,
                      child: const Text("Register"),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

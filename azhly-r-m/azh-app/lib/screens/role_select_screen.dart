import 'package:flutter/material.dart';
import '../models/roles.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'dart:ui';

class RoleSelectScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const RoleSelectScreen({
    super.key,
    required this.userData,
  });

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

              borderRadius: BorderRadius.circular(28),

              border: Border.all(
                color: Colors.white24,
              ),
            ),

            child: Column(
              children: [

                Image.asset(
                  "assets/images/azhly_logo.png",
                  width: 90,
                ),

                const SizedBox(height: 18),

                const Text(
                  "Select Your Role",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Choose how you want to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 28),

                for (final role in AzhlyRole.values) ...[
                  _RoleCard(
                    role: role,
                    userData: userData,
                  ),

                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  ),
)

    );     
  }

  }

class _RoleCard extends StatelessWidget {
  final AzhlyRole role;
  final Map<String, dynamic> userData;

  const _RoleCard({
    required this.role,
    required this.userData,
  });

  IconData get _icon {
    switch (role) {
      case AzhlyRole.teacher:
        return Icons.school_outlined;

      case AzhlyRole.crGr:
        return Icons.groups_outlined;

      case AzhlyRole.student:
        return Icons.person_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardScreen(
              role: role,
              userData: userData,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _icon,
                color: AppColors.purple,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    role.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: dimColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: dimColor,
            ),
          ],
        ),
      ),
    );
  }
}

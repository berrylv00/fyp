import 'package:flutter/material.dart';
import '../models/roles.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Continue as",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Choose your role",
                style: TextStyle(
                  color: dimColor,
                ),
              ),
              const SizedBox(height: 30),
              for (final role in AzhlyRole.values) ...[
                _RoleCard(
                  role: role,
                  userData: userData,
                ),
                const SizedBox(height: 15),
              ],
            ],
          ),
        ),
      ),
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

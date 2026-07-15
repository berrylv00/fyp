import 'package:flutter/material.dart';
import '../models/roles.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

/// Shared Profile tab — same layout for every role, contents differ
/// slightly by [role].
class ProfileScreen extends StatelessWidget {
  final AzhlyRole role;
  final String displayName;
  final String avatarInitials;

  const ProfileScreen({
    super.key,
    required this.role,
    required this.displayName,
    required this.avatarInitials,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.purple.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.purple, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              avatarInitials,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.purple),
            ),
          ),
          const SizedBox(height: 12),
          Text(displayName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.purple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              role.label,
              style: const TextStyle(color: AppColors.purple, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                _tile(Icons.badge_outlined, 'Department', 'Computer Science', textColor, dimColor),
                Divider(height: 1, color: borderColor),
                _tile(Icons.notifications_outlined, 'Notifications', 'On', textColor, dimColor),
                Divider(height: 1, color: borderColor),
                _tile(Icons.dark_mode_outlined, 'Theme', 'System', textColor, dimColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              ),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String label, String value, Color textColor, Color dimColor) {
    return ListTile(
      leading: Icon(icon, color: AppColors.purple, size: 20),
      title: Text(label, style: TextStyle(fontSize: 13, color: textColor)),
      trailing: Text(value, style: TextStyle(fontSize: 12, color: dimColor)),
    );
  }
}

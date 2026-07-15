import 'package:flutter/material.dart';
import '../models/roles.dart';
import '../theme/app_theme.dart';
import '../widgets/class_card.dart';

/// Shared Home / dashboard tab — same layout for every role. Shows a
/// quick overview (today's booked classes, makeup classes) as stat
/// cards, followed by today's class list.
class HomeScreen extends StatelessWidget {
  final AzhlyRole role;
  final String displayName;

  const HomeScreen({super.key, required this.role, required this.displayName});

  // Replace with real data from your backend / provider.
  static const _todayClasses = [
    {
      'department': 'CS',
      'roomNo': '112',
      'block': 'B',
      'floor': '1',
      'subject': 'Data Structures',
      'timeSlot': '10:00 - 11:30 AM',
      'teacherName': 'Dr Bilal',
    },
    {
      'department': 'CS',
      'roomNo': '213',
      'block': 'B',
      'floor': '2',
      'subject': 'Machine Learning',
      'timeSlot': '1:30 - 3:00 PM',
      'teacherName': 'Miss Ayesha',
    },
  ];

  static const _makeupClasses = [
    {
      'department': 'CS',
      'roomNo': '301',
      'block': 'B',
      'floor': '3',
      'subject': 'Artificial Intelligence (Makeup)',
      'timeSlot': '4:30 - 6:00 PM',
      'teacherName': 'Mr Farhan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, $displayName',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor),
          ),
          const SizedBox(height: 2),
          Text(
            "Here's what's happening today.",
            style: TextStyle(fontSize: 12, color: dimColor),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.event_available_outlined,
                  label: 'Booked today',
                  value: '${_todayClasses.length}',
                  color: AppColors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.update_outlined,
                  label: 'Makeup classes',
                  value: '${_makeupClasses.length}',
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            "Today's classes",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
          ),
          const SizedBox(height: 10),
          for (final c in _todayClasses)
            ClassCard(
              department: c['department']!,
              roomNo: c['roomNo']!,
              block: c['block']!,
              floor: c['floor']!,
              subject: c['subject']!,
              timeSlot: c['timeSlot']!,
              teacherName: role == AzhlyRole.teacher ? null : c['teacherName'],
            ),
          const SizedBox(height: 10),
          Text(
            'Makeup classes',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
          ),
          const SizedBox(height: 10),
          for (final c in _makeupClasses)
            ClassCard(
              department: c['department']!,
              roomNo: c['roomNo']!,
              block: c['block']!,
              floor: c['floor']!,
              subject: c['subject']!,
              timeSlot: c['timeSlot']!,
              teacherName: role == AzhlyRole.teacher ? null : c['teacherName'],
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: dimColor)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A single scheduled-class card.
///
/// Used in two places:
///  - Teacher > My Schedule: [teacherName] is left null, since teachers
///    don't need to see their own name on every card.
///  - Student / CR-GR > My Classes: [teacherName] is provided, formatted
///    like "CS  Room No: 101  B  Floor: 1  Miss Ayesha  1:30pm-3:00pm
///    Discrete Structures".
class ClassCard extends StatelessWidget {
  final String department; // e.g. "CS"
  final String roomNo; // e.g. "101"
  final String block; // e.g. "B"
  final String floor; // e.g. "1"
  final String subject; // e.g. "Discrete Structures"
  final String timeSlot; // e.g. "1:30 PM - 3:00 PM"
  final String? teacherName; // null on the Teacher's own schedule

  const ClassCard({
    super.key,
    required this.department,
    required this.roomNo,
    required this.block,
    required this.floor,
    required this.subject,
    required this.timeSlot,
    this.teacherName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  department,
                  style: const TextStyle(
                    color: AppColors.purple,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                timeSlot,
                style: TextStyle(
                    color: dimColor, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subject,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 4,
            children: [
              _meta('Room No', roomNo, textColor, dimColor),
              _meta('Block', block, textColor, dimColor),
              _meta('Floor', floor, textColor, dimColor),
              if (teacherName != null)
                _meta('Teacher', teacherName!, textColor, dimColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _meta(String label, String value, Color textColor, Color dimColor) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 11.5, color: dimColor),
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

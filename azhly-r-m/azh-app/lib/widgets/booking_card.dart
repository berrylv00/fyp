import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../theme/app_theme.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    Color statusColor;
    String statusText;

    switch (booking.status) {
      case BookingStatus.pending:
        statusColor = Colors.orange;
        statusText = "Pending";
        break;

      case BookingStatus.approved:
        statusColor = AppColors.green;
        statusText = "Approved";
        break;

      case BookingStatus.rejected:
        statusColor = Colors.red;
        statusText = "Rejected";
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.meeting_room_outlined,
                color: AppColors.purple,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Room ${booking.room.roomNo}",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            booking.subject,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Teacher: ${booking.teacherName}",
            style: TextStyle(
              color: dimColor,
            ),
          ),
          Text(
            "Student: ${booking.studentName}",
            style: TextStyle(
              color: dimColor,
            ),
          ),
          Text(
            "Purpose: ${booking.purpose}",
            style: TextStyle(
              color: dimColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${booking.room.department} • ${booking.room.blockName} • Floor ${booking.room.floorNo}",
            style: TextStyle(
              color: AppColors.purple,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

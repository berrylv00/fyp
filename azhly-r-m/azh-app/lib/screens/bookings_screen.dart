import 'package:flutter/material.dart';

import '../models/booking.dart';
import '../theme/app_theme.dart';
import '../widgets/booking_card.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return ValueListenableBuilder<List<Booking>>(
      valueListenable: BookingStore.bookings,
      builder: (context, bookings, _) {
        if (bookings.isEmpty) {
          return Center(
            child: Text(
              "No booking requests yet.",
              style: TextStyle(
                color: dimColor,
                fontSize: 14,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            16,
          ),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];

            return BookingCard(
              booking: booking,
            );
          },
        );
      },
    );
  }
}

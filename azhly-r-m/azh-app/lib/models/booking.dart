import 'package:flutter/foundation.dart';
import 'room.dart';

enum BookingStatus {
  pending,
  approved,
  rejected,
}

class Booking {
  final String id;
  final Room room;

  final String studentName;
  final String teacherName;
  final String subject;
  final String purpose;

  BookingStatus status;

  final DateTime createdAt;

  Booking({
    required this.id,
    required this.room,
    required this.studentName,
    required this.teacherName,
    required this.subject,
    required this.purpose,
    this.status = BookingStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class BookingStore {
  BookingStore._();

  static final ValueNotifier<List<Booking>> bookings =
      ValueNotifier<List<Booking>>([]);

  static void add(Booking booking) {
    bookings.value = [...bookings.value, booking];
  }

  static void updateStatus(
    String id,
    BookingStatus status,
  ) {
    final list = [...bookings.value];

    final index = list.indexWhere((b) => b.id == id);

    if (index == -1) return;

    list[index].status = status;

    bookings.value = list;
  }

  static Booking? getById(String id) {
    try {
      return bookings.value.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  static void remove(String id) {
    bookings.value = bookings.value.where((b) => b.id != id).toList();
  }

  static void clear() {
    bookings.value = [];
  }
}

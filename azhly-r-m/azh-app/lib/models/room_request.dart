import 'package:flutter/foundation.dart';
import '../models/room.dart';

/// A room suggestion raised by a student.
/// It is approved by CR/GR before forwarding to teacher.
class RoomRequest {
  final String id;
  final Room room;

  final String teacherName;
  final String subject;
  final String purpose;
  final String studentName;

  RoomRequest({
    required this.id,
    required this.room,
    required this.teacherName,
    required this.subject,
    required this.purpose,
    required this.studentName,
  });
}

/// Temporary local store.
/// Later this can be replaced with backend API.
class RoomRequestStore {
  RoomRequestStore._();

  static final ValueNotifier<List<RoomRequest>> pending = ValueNotifier([]);

  static void add(RoomRequest request) {
    pending.value = [...pending.value, request];
  }

  static void remove(String id) {
    pending.value = pending.value.where((r) => r.id != id).toList();
  }
}

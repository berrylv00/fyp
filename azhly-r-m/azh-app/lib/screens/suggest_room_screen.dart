import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/notification_model.dart';
import '../models/room.dart';
import '../models/room_request.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/booking_form_sheet.dart';
import '../widgets/confirmation_overlay.dart';
import '../widgets/room_card.dart';

/// Students can't request a teacher directly.
/// Their suggestion first goes to the CR/GR.
class SuggestRoomScreen extends StatefulWidget {
  final String studentName;

  const SuggestRoomScreen({
    super.key,
    required this.studentName,
  });

  @override
  State<SuggestRoomScreen> createState() => _SuggestRoomScreenState();
}

class _SuggestRoomScreenState extends State<SuggestRoomScreen> {
  final ApiService _api = ApiService();

  List<Room> rooms = [];

  bool loading = true;

  int _requestCounter = 0;

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      final data = await _api.getRooms();

      setState(() {
        rooms = data;
        loading = false;
      });
    } catch (e) {
      debugPrint("Room loading error: $e");

      setState(() {
        loading = false;
      });
    }
  }

  void _suggestRoom(Room room) {
    showBookingFormSheet(
      context,
      room: room,
      submitLabel: "Send to CR/GR",
      onSubmit: (teacherName, purpose, subject) async {
        // SAME ID for both Booking and RoomRequest
        final bookingId =
            "req_${DateTime.now().millisecondsSinceEpoch}_${_requestCounter++}";

        // Student -> CR/GR Request
        RoomRequestStore.add(
          RoomRequest(
            id: bookingId,
            room: room,
            teacherName: teacherName,
            subject: subject,
            purpose: purpose,
            studentName: widget.studentName,
          ),
        );

        // Student Booking
        BookingStore.add(
          Booking(
            id: bookingId,
            room: room,
            studentName: widget.studentName,
            teacherName: teacherName,
            subject: subject,
            purpose: purpose,
            status: BookingStatus.pending,
          ),
        );

        // Student Notification
        NotificationStore.add(
          AppNotification(
            id: "noti_${DateTime.now().millisecondsSinceEpoch}",
            title: "Booking Request Sent",
            message:
                "Your booking request for Room ${room.roomNo} is waiting for CR/GR approval.",
            type: NotificationType.student,
          ),
        );

        await showConfirmationOverlay(
          context,
          title: "Sent to CR/GR",
          subtitle:
              "Your request has been sent successfully and is waiting for approval.",
          icon: Icons.send_rounded,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggest a Room'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : rooms.isEmpty
              ? const Center(child: Text('No rooms available'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return RoomCard(
                      room: room,
                      onTap: () => _suggestRoom(room),
                    );
                  },
                ),
    );
  }
}

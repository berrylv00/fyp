import 'package:flutter/material.dart';

import '../models/roles.dart';
import '../models/room.dart';
import '../models/room_request.dart';

import '../services/api_service.dart';

import '../theme/app_theme.dart';
import '../models/booking.dart';
import '../models/notification_model.dart';
import '../widgets/booking_form_sheet.dart';
import '../widgets/room_card.dart';
import '../widgets/smart_engine_overlay.dart';

/// Room Finder — available to Teacher and CR/GR only.
class RoomFinderScreen extends StatefulWidget {
  final AzhlyRole role;

  const RoomFinderScreen({
    super.key,
    required this.role,
  });

  @override
  State<RoomFinderScreen> createState() => _RoomFinderScreenState();
}

class _RoomFinderScreenState extends State<RoomFinderScreen> {
  int _tabIndex = 0;

  // Backend rooms
  List<Room> rooms = [];

  bool loading = true;

  bool get _isCrGr => widget.role == AzhlyRole.crGr;

  @override
  void initState() {
    super.initState();

    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      final data = await ApiService().getRooms();

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

  void _bookRoom(Room room) {
  showBookingFormSheet(
    context,
    room: room,
    submitLabel: 'Request to Smart Engine',
    onSubmit: (teacherName, purpose, subject) async {

      try {

        await ApiService().requestBooking(
          studentName: teacherName,
          roomNo: room.roomNo,
          day: "Monday",
          timeSlot: room.timeSlot,
        );

        if (!mounted) return;
        await showSmartEngineOverlay(context);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Booking request sent to Smart Engine"),
          ),
        );

      } catch (e) {

        debugPrint("Booking Error: $e");
        if(! mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Booking failed"),
          ),
        );
      }
    },
  );
}

  Future<void> _approveRequest(RoomRequest request) async {
    final approved = await showSmartEngineOverlay(
      context,
      processingTitle: 'Forwarding to Teacher',
    );

    if (!mounted) return;

    // Update Booking Status
    BookingStore.updateStatus(
      request.id,
      approved ? BookingStatus.approved : BookingStatus.rejected,
    );

    // Student Notification
    NotificationStore.add(
      AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: approved ? "Booking Approved" : "Booking Rejected",
        message: approved
            ? "Your room ${request.room.roomNo} has been approved."
            : "Your booking was rejected because of a conflict.",
        type: NotificationType.student,
      ),
    );

    // Admin Notification
    NotificationStore.add(
      AppNotification(
        id: "${DateTime.now().millisecondsSinceEpoch}admin",
        title: approved ? "New Approved Booking" : "Booking Conflict",
        message: "${request.studentName} • Room ${request.room.roomNo}",
        type: NotificationType.admin,
      ),
    );

    RoomRequestStore.remove(request.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approved ? "Approved" : "Rejected",
        ),
      ),
    );
  }

  void _rejectRequest(RoomRequest request) {
    BookingStore.updateStatus(
      request.id,
      BookingStatus.rejected,
    );

    NotificationStore.add(
      AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: "Booking Rejected",
        message: "Your request for Room ${request.room.roomNo} was rejected.",
        type: NotificationType.student,
      ),
    );

    NotificationStore.add(
      AppNotification(
        id: "${DateTime.now().millisecondsSinceEpoch}admin",
        title: "Booking Rejected",
        message: "${request.studentName}'s request was rejected.",
        type: NotificationType.admin,
      ),
    );

    RoomRequestStore.remove(request.id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Request Declined",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextDim
        : AppColors.lightTextDim;

    return Column(
      children: [
        if (_isCrGr)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              4,
            ),
            child: ValueListenableBuilder<List<RoomRequest>>(
              valueListenable: RoomRequestStore.pending,
              builder: (context, requests, _) {
                return Row(
                  children: [
                    _tabChip(
                      'Find Room',
                      0,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    _tabChip(
                      'Requests${requests.isNotEmpty ? ' (${requests.length})' : ''}',
                      1,
                    ),
                  ],
                );
              },
            ),
          ),
        Expanded(
          child: (_isCrGr && _tabIndex == 1)
              ? _buildRequestsTab(dimColor)
              : _buildFindRoomTab(),
        ),
      ],
    );
  }

  Widget _buildFindRoomTab() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (rooms.isEmpty) {
      return const Center(
        child: Text(
          "No rooms available",
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        16,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];

        return RoomCard(
          room: room,
          onTap: () => _bookRoom(room),
        );
      },
    );
  }

  Widget _buildRequestsTab(Color dimColor) {
    return ValueListenableBuilder<List<RoomRequest>>(
      valueListenable: RoomRequestStore.pending,
      builder: (context, requests, _) {
        if (requests.isEmpty) {
          return Center(
            child: Text(
              'No pending student requests',
              style: TextStyle(
                color: dimColor,
                fontSize: 12,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            16,
          ),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final r = requests[index];

            return _RequestCard(
              request: r,
              onApprove: () => _approveRequest(r),
              onReject: () => _rejectRequest(r),
            );
          },
        );
      },
    );
  }

  Widget _tabChip(String label, int index) {
    final selected = _tabIndex == index;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _tabIndex = index;
        });
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  final RoomRequest request;

  final VoidCallback onApprove;

  final VoidCallback onReject;

  const _RequestCard({
    required this.request,
    required this.onApprove,
    required this.onReject,
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
        border: Border(
          left: const BorderSide(
            color: AppColors.amber,
            width: 3,
          ),
          top: BorderSide(
            color: borderColor,
          ),
          right: BorderSide(
            color: borderColor,
          ),
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room ${request.room.roomNo} · ${request.subject}',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'From: ${request.studentName}',
            style: TextStyle(
              color: dimColor,
              fontSize: 11.5,
            ),
          ),
          Text(
            'Teacher: ${request.teacherName}',
            style: TextStyle(
              color: dimColor,
              fontSize: 11.5,
            ),
          ),
          Text(
            'Purpose: ${request.purpose}',
            style: TextStyle(
              color: dimColor,
              fontSize: 11.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReject,
                  child: const Text(
                    'Reject',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: onApprove,
                  child: const Text(
                    'Approve',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

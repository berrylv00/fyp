import 'package:flutter/material.dart';
import '../models/roles.dart';
import '../widgets/azhly_bottom_nav.dart';
import 'home_screen.dart';
import 'my_classes_screen.dart';
import 'profile_screen.dart';
import 'room_finder_screen.dart';
import 'suggest_room_screen.dart';
import 'teacher_schedule_screen.dart';
import 'timetable_screen.dart';

class DashboardScreen extends StatefulWidget {
  final AzhlyRole role;
  final Map<String, dynamic> userData;

  const DashboardScreen({
    super.key,
    required this.role,
    required this.userData,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  String get _displayName {
    return widget.userData["adminName"] ?? "User";
  }

  String get _avatarInitials {
    final name = _displayName.trim();

    if (name.isEmpty) return "U";

    final parts = name.split(" ");

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String get _appBarTitle {
    switch (_navIndex) {
      case 0:
        return "Home";

      case 1:
        return widget.role == AzhlyRole.student
            ? "Suggest Room"
            : "Room Finder";

      case 2:
        return "Timetable";

      case 3:
        return widget.role == AzhlyRole.teacher ? "My Schedule" : "My Classes";

      case 4:
        return "Profile";

      default:
        return "AZHly";
    }
  }

  List<Widget> get _pages {
    return [
      HomeScreen(
        role: widget.role,
        displayName: _displayName,
      ),
      widget.role == AzhlyRole.student
          ? SuggestRoomScreen(
              studentName: _displayName,
            )
          : RoomFinderScreen(
              role: widget.role,
            ),
      const TimetableScreen(),
      widget.role == AzhlyRole.teacher
          ? const TeacherScheduleBody()
          : const MyClassesBody(),
      ProfileScreen(
        role: widget.role,
        displayName: _displayName,
        avatarInitials: _avatarInitials,
      ),
    ];
  }

  Widget _buildNav() {
    switch (widget.role) {
      case AzhlyRole.teacher:
        return AzhlyBottomNav.teacher(
          currentIndex: _navIndex,
          avatarInitials: _avatarInitials,
          onTap: (index) {
            setState(() {
              _navIndex = index;
            });
          },
        );

      case AzhlyRole.crGr:
        return AzhlyBottomNav.crGr(
          currentIndex: _navIndex,
          avatarInitials: _avatarInitials,
          onTap: (index) {
            setState(() {
              _navIndex = index;
            });
          },
        );

      case AzhlyRole.student:
        return AzhlyBottomNav.student(
          currentIndex: _navIndex,
          avatarInitials: _avatarInitials,
          onTap: (index) {
            setState(() {
              _navIndex = index;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: IndexedStack(
        index: _navIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildNav(),
    );
  }
}

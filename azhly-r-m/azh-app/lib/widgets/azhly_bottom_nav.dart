import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// One nav item. Pass [avatarUrl]/[avatarInitials] instead of [icon] for
/// the Profile tab so it renders as a circular photo/avatar, matching the
/// profile picture shown in the app header — not a generic person icon.
class AzhlyNavItem {
  final String label;
  final IconData? icon;
  final String? avatarUrl;
  final String? avatarInitials;

  const AzhlyNavItem({
    required this.label,
    this.icon,
    this.avatarUrl,
    this.avatarInitials,
  }) : assert(icon != null || avatarInitials != null || avatarUrl != null);
}

class AzhlyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AzhlyNavItem> items;

  const AzhlyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  /// Preset nav for the Teacher role: Dashboard, Room Finder,
  /// Timetable, My Schedule, Profile.
  factory AzhlyBottomNav.teacher({
    required int currentIndex,
    required ValueChanged<int> onTap,
    String? avatarUrl,
    String avatarInitials = 'T',
  }) {
    return AzhlyBottomNav(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const AzhlyNavItem(label: 'Home', icon: Icons.home_outlined),
        const AzhlyNavItem(label: 'Room Finder', icon: Icons.search),
        const AzhlyNavItem(label: 'Timetable', icon: Icons.access_time),
        const AzhlyNavItem(label: 'My Schedule', icon: Icons.event_note_outlined),
        AzhlyNavItem(label: 'Profile', avatarUrl: avatarUrl, avatarInitials: avatarInitials),
      ],
    );
  }

  /// Preset nav for CR/GR: Dashboard, Room Finder, Timetable,
  /// My Classes, Profile.
  factory AzhlyBottomNav.crGr({
    required int currentIndex,
    required ValueChanged<int> onTap,
    String? avatarUrl,
    String avatarInitials = 'CR',
  }) {
    return AzhlyBottomNav(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const AzhlyNavItem(label: 'Home', icon: Icons.home_outlined),
        const AzhlyNavItem(label: 'Room Finder', icon: Icons.search),
        const AzhlyNavItem(label: 'Timetable', icon: Icons.access_time),
        const AzhlyNavItem(label: 'My Classes', icon: Icons.grid_view_outlined),
        AzhlyNavItem(label: 'Profile', avatarUrl: avatarUrl, avatarInitials: avatarInitials),
      ],
    );
  }

  /// Preset nav for Student: Dashboard, Suggest Room, Timetable,
  /// My Classes, Profile.
  factory AzhlyBottomNav.student({
    required int currentIndex,
    required ValueChanged<int> onTap,
    String? avatarUrl,
    String avatarInitials = 'S',
  }) {
    return AzhlyBottomNav(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const AzhlyNavItem(label: 'Home', icon: Icons.home_outlined),
        const AzhlyNavItem(label: 'Suggest Room', icon: Icons.lightbulb_outline),
        const AzhlyNavItem(label: 'Timetable', icon: Icons.access_time),
        const AzhlyNavItem(label: 'My Classes', icon: Icons.grid_view_outlined),
        AzhlyNavItem(label: 'Profile', avatarUrl: avatarUrl, avatarInitials: avatarInitials),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: theme.backgroundColor,
      selectedItemColor: theme.selectedItemColor,
      unselectedItemColor: theme.unselectedItemColor,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: [
        for (int i = 0; i < items.length; i++)
          BottomNavigationBarItem(
            label: items[i].label,
            icon: _buildIcon(items[i], selected: i == currentIndex),
          ),
      ],
    );
  }

  Widget _buildIcon(AzhlyNavItem item, {required bool selected}) {
    if (item.icon != null) {
      return Icon(item.icon);
    }

    final borderColor = selected ? AppColors.purple : AppColors.darkTextDim;

    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
        image: item.avatarUrl != null
            ? DecorationImage(image: NetworkImage(item.avatarUrl!), fit: BoxFit.cover)
            : null,
        color: item.avatarUrl == null ? AppColors.purple.withValues(alpha: 0.15) : null,
      ),
      alignment: Alignment.center,
      child: item.avatarUrl == null
          ? Text(
              item.avatarInitials ?? '',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: borderColor),
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/class_card.dart';

/// Shared weekly Timetable tab — same for every role.
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int _dayIndex = 2; // Wed selected by default

  // Replace with real data from your backend / provider.
  static const _byDay = {
    'Mon': [
      {'department': 'CS', 'roomNo': '104', 'block': 'A', 'floor': '1', 'subject': 'Calculus II', 'timeSlot': '9:00 - 10:30 AM'},
    ],
    'Tue': [
      {'department': 'CS', 'roomNo': '210', 'block': 'A', 'floor': '2', 'subject': 'Software Engineering', 'timeSlot': '10:00 - 11:30 AM'},
    ],
    'Wed': [
      {'department': 'CS', 'roomNo': '112', 'block': 'B', 'floor': '1', 'subject': 'Data Structures', 'timeSlot': '10:00 - 11:30 AM'},
      {'department': 'CS', 'roomNo': '213', 'block': 'B', 'floor': '2', 'subject': 'Machine Learning', 'timeSlot': '1:30 - 3:00 PM'},
    ],
    'Thu': [
      {'department': 'CS', 'roomNo': '305', 'block': 'C', 'floor': '3', 'subject': 'Machine Learning', 'timeSlot': '1:30 - 3:00 PM'},
    ],
    'Fri': [
      {'department': 'CS', 'roomNo': '101', 'block': 'B', 'floor': '1', 'subject': 'Discrete Structures', 'timeSlot': '1:30 - 3:00 PM'},
    ],
    'Sat': <Map<String, String>>[],
  };

  @override
  Widget build(BuildContext context) {
    final dimColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextDim
        : AppColors.lightTextDim;
    final classes = _byDay[_days[_dayIndex]] ?? const [];

    return Column(
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            itemCount: _days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final selected = i == _dayIndex;
              return ChoiceChip(
                label: Text(_days[i]),
                selected: selected,
                onSelected: (_) => setState(() => _dayIndex = i),
              );
            },
          ),
        ),
        Expanded(
          child: classes.isEmpty
              ? Center(
                  child: Text('No classes scheduled', style: TextStyle(color: dimColor, fontSize: 12)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final c = classes[index];
                    return ClassCard(
                      department: c['department']!,
                      roomNo: c['roomNo']!,
                      block: c['block']!,
                      floor: c['floor']!,
                      subject: c['subject']!,
                      timeSlot: c['timeSlot']!,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

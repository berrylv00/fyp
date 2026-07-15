import 'package:flutter/material.dart';
import '../widgets/class_card.dart';

/// Teacher's "My Schedule" body — shows the teacher's own scheduled
/// classes; no teacher name is shown on the cards since it's their own
/// timetable.
///
/// This is body-only (no Scaffold/AppBar/bottom nav) — it's placed
/// inside DashboardScreen's shared shell.
class TeacherScheduleBody extends StatefulWidget {
  const TeacherScheduleBody({super.key});

  @override
  State<TeacherScheduleBody> createState() => _TeacherScheduleBodyState();
}

class _TeacherScheduleBodyState extends State<TeacherScheduleBody> {
  int _tabIndex = 0; // 0 = Today, 1 = Week

  // Replace with real data from your backend / provider.
  final List<Map<String, String>> _todayClasses = const [
    {
      'department': 'CS',
      'roomNo': '112',
      'block': 'B',
      'floor': '1',
      'subject': 'Data Structures',
      'timeSlot': '10:00 - 11:30 AM',
    },
    {
      'department': 'CS',
      'roomNo': '213',
      'block': 'B',
      'floor': '2',
      'subject': 'Machine Learning',
      'timeSlot': '1:30 - 3:00 PM',
    },
  ];

  final List<Map<String, String>> _weekClasses = const [
    {
      'department': 'CS',
      'roomNo': '112',
      'block': 'B',
      'floor': '1',
      'subject': 'Data Structures',
      'timeSlot': 'Wed · 10:00 - 11:30 AM',
    },
    {
      'department': 'CS',
      'roomNo': '305',
      'block': 'C',
      'floor': '3',
      'subject': 'Machine Learning',
      'timeSlot': 'Thu · 1:30 - 3:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final classes = _tabIndex == 0 ? _todayClasses : _weekClasses;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _tabChip('Today', 0),
              const SizedBox(width: 8),
              _tabChip('Week', 1),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
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
                // teacherName intentionally omitted here
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _tabChip(String label, int index) {
    final selected = _tabIndex == index;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _tabIndex = index),
    );
  }
}

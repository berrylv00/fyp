import 'package:flutter/material.dart';
import '../widgets/class_card.dart';

/// Student / CR-GR "My Classes" body. Each card shows department,
/// room no, block, floor, teacher name, time slot, and subject —
/// e.g. "CS  Room No: 101  B  Floor: 1  Miss Ayesha  1:30pm-3:00pm
/// Discrete Structures".
///
/// This is body-only (no Scaffold/AppBar/bottom nav) — it's placed
/// inside DashboardScreen's shared shell.
class MyClassesBody extends StatefulWidget {
  const MyClassesBody({super.key});

  @override
  State<MyClassesBody> createState() => _MyClassesBodyState();
}

class _MyClassesBodyState extends State<MyClassesBody> {
  int _tabIndex = 0; // 0 = Today, 1 = Upcoming

  // Replace with real data from your backend / provider.
  final List<Map<String, String>> _todayClasses = const [
    {
      'department': 'CS',
      'roomNo': '101',
      'block': 'B',
      'floor': '1',
      'subject': 'Discrete Structures',
      'timeSlot': '1:30 PM - 3:00 PM',
      'teacherName': 'Miss Ayesha',
    },
    {
      'department': 'CS',
      'roomNo': '301',
      'block': 'B',
      'floor': '3',
      'subject': 'Artificial Intelligence',
      'timeSlot': '3:00 PM - 4:30 PM',
      'teacherName': 'Mr Farhan',
    },
  ];

  final List<Map<String, String>> _upcomingClasses = const [
    {
      'department': 'CS',
      'roomNo': '210',
      'block': 'A',
      'floor': '2',
      'subject': 'Software Engineering',
      'timeSlot': 'Tomorrow · 10:00 AM - 11:30 AM',
      'teacherName': 'Dr Bilal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final classes = _tabIndex == 0 ? _todayClasses : _upcomingClasses;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _tabChip('Today', 0),
              const SizedBox(width: 8),
              _tabChip('Upcoming', 1),
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
                teacherName: c['teacherName'],
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

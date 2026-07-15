import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/room.dart';

/// Opens the booking form as a bottom sheet for [room]. Calls [onSubmit]
/// with the entered teacher name / purpose / subject when the user taps
/// the submit button (labelled [submitLabel]).
Future<void> showBookingFormSheet(
  BuildContext context, {
  required Room room,
  required String submitLabel,
  required void Function(String teacherName, String purpose, String subject)
      onSubmit,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _BookingFormSheet(
      room: room,
      submitLabel: submitLabel,
      onSubmit: onSubmit,
    ),
  );
}

class _BookingFormSheet extends StatefulWidget {
  final Room room;
  final String submitLabel;
  final void Function(String teacherName, String purpose, String subject)
      onSubmit;

  const _BookingFormSheet({
    required this.room,
    required this.submitLabel,
    required this.onSubmit,
  });

  @override
  State<_BookingFormSheet> createState() => _BookingFormSheetState();
}

class _BookingFormSheetState extends State<_BookingFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _teacherCtrl = TextEditingController();
  final _purposeCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();

  @override
  void dispose() {
    _teacherCtrl.dispose();
    _purposeCtrl.dispose();
    _subjectCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: dimColor.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Book Room ${widget.room.roomNo}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor),
              ),
              const SizedBox(height: 2),
              Text(
                '${widget.room.department} · ${widget.room.blockName} · Floor ${widget.room.floorNo}',
                style: TextStyle(fontSize: 11.5, color: dimColor),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _teacherCtrl,
                decoration: const InputDecoration(labelText: 'Teacher name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _subjectCtrl,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _purposeCtrl,
                decoration: const InputDecoration(labelText: 'Purpose'),
                maxLines: 2,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    Navigator.of(context).pop();
                    widget.onSubmit(
                      _teacherCtrl.text.trim(),
                      _purposeCtrl.text.trim(),
                      _subjectCtrl.text.trim(),
                    );
                  },
                  child: Text(widget.submitLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

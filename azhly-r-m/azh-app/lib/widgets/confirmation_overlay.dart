import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A small card that pops up, shows an icon + message, then auto-dismisses
/// itself after [duration]. Used for lightweight confirmations that don't
/// need the full Smart Engine animation (e.g. "Sent to CR/GR").
Future<void> showConfirmationOverlay(
  BuildContext context, {
  required String title,
  required String subtitle,
  IconData icon = Icons.send_rounded,
  Duration duration = const Duration(seconds: 2),
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => _ConfirmationDialog(
      title: title,
      subtitle: subtitle,
      icon: icon,
      duration: duration,
    ),
  );
}

class _ConfirmationDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Duration duration;

  const _ConfirmationDialog({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.duration,
  });

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 230,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 350),
              curve: Curves.elasticOut,
              builder: (context, v, child) =>
                  Transform.scale(scale: v, child: child),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purple.withValues(alpha: 0.15),
                ),
                alignment: Alignment.center,
                child: Icon(widget.icon, color: AppColors.purple, size: 24),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.5, color: dimColor),
            ),
          ],
        ),
      ),
    );
  }
}

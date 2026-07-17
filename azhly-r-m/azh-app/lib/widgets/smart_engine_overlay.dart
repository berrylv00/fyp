import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dart:ui';

/// Shows the "Smart Engine" processing overlay: a glowing AZHly icon that
/// pulses while cycling through stage labels (Fetching timetable →
/// Allocating room → Detecting conflicts), then swaps to a small
/// approved/rejected result card that auto-dismisses.
///
/// Returns `true` if the request was approved, `false` if rejected.
Future<bool> showSmartEngineOverlay(
  BuildContext context, {
  String processingTitle = 'Smart Engine',
}) async {
  return await showDialog<bool?>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (_) => _SmartEngineDialog(processingTitle: processingTitle),
      ) ??
      false;
}

class _SmartEngineDialog extends StatefulWidget {
  final String processingTitle;
  const _SmartEngineDialog({required this.processingTitle});

  @override
  State<_SmartEngineDialog> createState() => _SmartEngineDialogState();
}

enum _EnginePhase { processing, result }

class _SmartEngineDialogState extends State<_SmartEngineDialog>
    with TickerProviderStateMixin {
  static const _stages = [
    'Fetching timetable',
    'Allocating room',
    'double _progress = 0'
    'Detecting conflicts',
  ];

  late final AnimationController _glowController;
  late final AnimationController _dotsController;
  Timer? _stageTimer;
  Timer? _resultTimer;

  _EnginePhase _phase = _EnginePhase.processing;
  int _stageIndex = 0;
  bool _approved = true;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    // ~1.6s per stage x 3 stages ≈ 5s of "processing".
    _stageTimer = Timer.periodic(const Duration(milliseconds: 1667), (t) {
      if (_stageIndex >= _stages.length - 1) {
        t.cancel();
        _finishProcessing();
        return;
      }
      setState(() => _stageIndex++);
    });
  }

  void _finishProcessing() {
    // Mostly approves — an occasional conflict gets rejected, which feels
    // more "alive" than always succeeding.
    _approved = Random().nextDouble() < 0.85;
    setState(() => _phase = _EnginePhase.result);
    _glowController.stop();
    _dotsController.stop();

    _resultTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop(_approved);
    });
  }

  @override
  void dispose() {
    _stageTimer?.cancel();
    _resultTimer?.cancel();
    _glowController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final dimColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

   return BackdropFilter(
  filter: ImageFilter.blur(
    sigmaX: 10,
    sigmaY: 10,
  ),
  child: Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    insetAnimationDuration: const Duration(milliseconds: 250),

    child: AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),
 decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(28),

  color: const Color(0xFF081426).withValues(
    alpha: 0.88,
  ),

  border: Border.all(
    color: AppColors.purple.withValues(alpha: .35),
    width: 1.2,
  ),

  boxShadow: [

    BoxShadow(
      color: Colors.black.withValues(alpha: .35),
      blurRadius: 28,
      offset: const Offset(0, 16),
    ),

    BoxShadow(
      color: AppColors.purple.withValues(alpha: .18),
      blurRadius: 40,
      spreadRadius: 2,
    ),

  ],
),

  }

  Widget _buildProcessing(Color textColor, Color dimColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final t = _glowController.value; // 0..1
            final scale = 0.92 + (t * 0.16);
            final glow = 0.25 + (t * 0.35);
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple.withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple.withValues(alpha: glow),
                    blurRadius: 22,
                    spreadRadius: 4,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.purple, AppColors.purpleDark],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.bolt, color: Colors.white, size: 22),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        Text(
          widget.processingTitle,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: _dotsController,
          builder: (context, child) {
            final dotCount =
                1 + (_dotsController.value * 3).floor().clamp(0, 2);
            final dots = '.' * dotCount;
            return Text(
              '${_stages[_stageIndex]}$dots',
              style: TextStyle(fontSize: 12, color: dimColor),
            );
          },
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _stages.length; i++) ...[
              _StepDot(active: i <= _stageIndex),
              if (i != _stages.length - 1)
                Container(
                  width: 14,
                  height: 1.5,
                  color: i < _stageIndex
                      ? AppColors.purple
                      : AppColors.purple.withValues(alpha: 0.2),
                ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildResult(Color textColor, Color dimColor) {
    final color = _approved ? AppColors.green : AppColors.red;
    final icon = _approved ? Icons.check_circle : Icons.cancel;
    final label = _approved ? 'Approved' : 'Rejected';
    final sub = _approved
        ? 'Room booked successfully'
        : 'Conflict found — try another room';

    return Column(
      mainAxisSize: MainAxisSize.min,
      key: const ValueKey('result'),
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 350),
          curve: Curves.elasticOut,
          builder: (context, v, child) =>
              Transform.scale(scale: v, child: child),
          child: Icon(icon, color: color, size: 46),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
        ),
        const SizedBox(height: 4),
        Text(
          sub,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.5, color: dimColor),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool active;
  const _StepDot({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            active ? AppColors.purple : AppColors.purple.withValues(alpha: 0.2),
      ),
    );
  }
}

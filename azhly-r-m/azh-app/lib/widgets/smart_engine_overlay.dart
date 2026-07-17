import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Smart Engine Processing Dialog
Future<bool> showSmartEngineOverlay(
  BuildContext context, {
  String processingTitle = "Smart Engine",
}) async {
  return await showDialog<bool?>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (_) => _SmartEngineDialog(
          processingTitle: processingTitle,
        ),
      ) ??
      false;
}

class _SmartEngineDialog extends StatefulWidget {
  final String processingTitle;

  const _SmartEngineDialog({
    super.key,
    required this.processingTitle,
  });

  @override
  State<_SmartEngineDialog> createState() =>
      _SmartEngineDialogState();
}

enum _EnginePhase {
  processing,
  result,
}

class _SmartEngineDialogState
    extends State<_SmartEngineDialog>
    with TickerProviderStateMixin {
  static const List<String> _stages = [
    "Reading Timetable",
    "Checking Availability",
    "Detecting Conflicts",
  ];

  late final AnimationController _glowController;
  late final AnimationController _dotsController;

  Timer? _stageTimer;
  Timer? _resultTimer;

  _EnginePhase _phase = _EnginePhase.processing;

  int _stageIndex = 0;

  bool _approved = true;

  double _progress = 0;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    )..repeat(reverse: true);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    )..repeat();

    _stageTimer = Timer.periodic(
      const Duration(milliseconds: 1300),
      (timer) {
        if (_stageIndex >= _stages.length - 1) {
          setState(() {
            _progress = 1.0;
          });

          timer.cancel();

          _finishProcessing();

          return;
        }

        setState(() {
          _stageIndex++;

          _progress =
              (_stageIndex + 1) / _stages.length;
        });
      },
    );
  }

  void _finishProcessing() {
    _approved = Random().nextDouble() < 0.85;

    setState(() {
      _phase = _EnginePhase.result;
    });

    _glowController.stop();

    _dotsController.stop();

    _resultTimer = Timer(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          Navigator.of(context).pop(_approved);
        }
      },
    );
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

    final glow = 8 + (_glowController.value * 10);

    final scale = 0.97 + (_glowController.value * 0.05);

    return Transform.scale(
      scale: scale,
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
          boxShadow: [

            BoxShadow(
              color: Colors.deepPurple.withValues(alpha: 0.12),
              blurRadius: glow,
              spreadRadius: 1,
            ),

            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.10),
              blurRadius: glow + 8,
            ),

          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Image.asset(
            "assets/images/azhly_logo.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  },
),

ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: LinearProgressIndicator(
    value: _progress,
    minHeight: 7,
    backgroundColor:
        Colors.white.withValues(alpha: 0.08),
    valueColor: const AlwaysStoppedAnimation(
      AppColors.purple,
    ),
  ),
),
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

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
    // ignore: unused_element_parameter
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
  
  int _progressPercent = 0;

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
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final textColor =
        isDark ? AppColors.darkText : AppColors.lightText;

    final dimColor =
        isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetAnimationDuration:
            const Duration(milliseconds: 250),

        child: AnimatedSize(
          duration:
              const Duration(milliseconds: 300),
          curve: Curves.easeOut,

          child: Container(
            width: 290,

            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 28,
            ),

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(28),

              color: const Color(
                0xFF081426,
              ).withValues(alpha: .88),

              border: Border.all(
                color: AppColors.purple
                    .withValues(alpha: .35),
                width: 1.2,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(alpha: .35),
                  blurRadius: 28,
                  offset: const Offset(0, 16),
                ),

                BoxShadow(
                  color: AppColors.purple
                      .withValues(alpha: .18),
                  blurRadius: 40,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: _phase ==
                    _EnginePhase.processing
                ? _buildProcessing(
                    textColor,
                    dimColor,
                  )
                : _buildResult(
                    textColor,
                    dimColor,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessing(
    Color textColor,
    Color dimColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {

            final glow =
                8 + (_glowController.value * 10);

            final scale =
                0.97 +
                    (_glowController.value * 0.05);

            return Transform.scale(
              scale: scale,
              child: Container(
                width: 92,
                height: 92,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white
                      .withValues(alpha: .04),

                  border: Border.all(
                    color: Colors.white
                        .withValues(alpha: .08),
                  ),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.deepPurple
                          .withValues(alpha: .12),
                      blurRadius: glow,
                    ),

                    BoxShadow(
                      color: Colors.blue
                          .withValues(alpha: .10),
                      blurRadius: glow + 8,
                    ),
                  ],
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(18),

                  child: Image.asset(
                    "assets/images/azhly_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      const SizedBox(height: 18),

        Text(
          widget.processingTitle,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        AnimatedBuilder(
          animation: _dotsController,
          builder: (context, child) {
            final dotCount =
                1 + (_dotsController.value * 3).floor().clamp(0, 2);

            return Text(
              "${_stages[_stageIndex]}${"." * dotCount}",
              style: TextStyle(
                color: dimColor,
                fontSize: 12,
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 7,
            backgroundColor:
                Colors.white.withValues(alpha: .08),
            valueColor:
                const AlwaysStoppedAnimation(
              AppColors.purple,
            ),
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _stages.length; i++) ...[
              _StepDot(active: i <= _stageIndex),

              if (i != _stages.length - 1)
                Container(
                  width: 22,
                  height: 2,
                  color: i < _stageIndex
                      ? AppColors.purple
                      : Colors.white.withValues(alpha: .10),
                ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildResult(
    Color textColor,
    Color dimColor,
  ) {
    final color =
        _approved ? AppColors.green : AppColors.red;

    final icon =
        _approved ? Icons.check_circle : Icons.cancel;

    final title =
        _approved ? "Approved" : "Conflict";

    final subtitle = _approved
        ? "Room allocated successfully."
        : "Alternative room suggested.";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 56,
        ),

        const SizedBox(height: 18),

        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dimColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool active;

  const _StepDot({
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? AppColors.purple
            : Colors.white.withValues(alpha: .15),
      ),
    );
  }
}
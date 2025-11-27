import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomRateChart extends StatelessWidget {
  final double completionRate;

  const CustomRateChart({super.key, required this.completionRate});

  @override
  Widget build(BuildContext context) {
    return CompletionRateCard(completionRate: completionRate.toInt());
  }
}

class CompletionRateCard extends StatelessWidget {
  final int completionRate;

  const CompletionRateCard({super.key, required this.completionRate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 140,

        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: completionRate / 100),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return CustomPaint(
              painter: SemiCircleProgressPainter(progress: value),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(value * 100).toInt()}%",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B7FD7),
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Completion Rate",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SemiCircleProgressPainter extends CustomPainter {
  final double progress;

  SemiCircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final radius = size.width / 2.5;
    const strokeWidth = 12.0;

    // Background arc
    final backgroundPaint =
        Paint()
          ..color = const Color(0xFFE0E0E0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    // Progress arc
    final progressPaint =
        Paint()
          ..color = const Color(0xFF6B9EFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

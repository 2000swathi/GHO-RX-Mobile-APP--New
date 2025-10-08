import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomRateChart extends StatelessWidget {
  const CustomRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompletionRateCard(
      completionRate: 86,
      completed: 18,
      total: 21,
    );
  }
}

class CompletionRateCard extends StatelessWidget {
  final int completionRate;
  final int completed;
  final int total;

  const CompletionRateCard({
    super.key,
    required this.completionRate,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 140,
        height: 140,
        child: CustomPaint(
          painter: SemiCircleProgressPainter(
            progress: completionRate / 100,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$completionRate%",
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

    // Background arc (light gray/purple)
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Progress arc (blue)
    final progressPaint = Paint()
      ..color = const Color(0xFF6B9EFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background semi-circle
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
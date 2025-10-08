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
    return SizedBox(
      width: 195,
      height: 285,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
            SizedBox(
              width: 100,
              height: 60,
              child: CustomPaint(
                painter: SemiCircleProgressPainter(
                  progress: completionRate / 100,
                ),
                child: Center(
                  child: Text(
                    "$completionRate%",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ),
              ),
            ),
           
            Text(
              "Completion Rate",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "$completed of $total completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
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
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 8;
    const strokeWidth = 8.0;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFBBDEFB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFF5C9FE5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Draw progress arc
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

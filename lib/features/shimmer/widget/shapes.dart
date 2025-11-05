import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A reusable shimmer shapes utility widget.
/// You can call shimmer widgets directly without creating an instance:
/// Example: ShimmerShapes.line(width: 120)
class ShimmerShapes extends StatelessWidget {
  const ShimmerShapes({super.key});

  @override
  Widget build(BuildContext context) {
    // Optional: You can return a small example shimmer preview or nothing
    return Center(child: line(width: 100));
  }

  /// 🔹 Reusable shimmer line (used for text placeholders)
  static Widget line({double width = 100, double height = 12}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  /// 🔹 Reusable shimmer box (used for cards/containers)
  static Widget box({double height = 100, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// 🔹 Reusable shimmer circle (used for avatar or icons)
  static Widget circle(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

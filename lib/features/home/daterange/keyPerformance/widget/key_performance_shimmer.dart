import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/widget/shapes.dart';

class KeyPerformanceShimmer extends StatelessWidget {
  const KeyPerformanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: ShimmerShapes.box(height: 100)),
            const SizedBox(width: 12),
            Expanded(child: ShimmerShapes.box(height: 100)),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(child: ShimmerShapes.box(height: 100)),
            const SizedBox(width: 12),
            Expanded(child: ShimmerShapes.box(height: 100)),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

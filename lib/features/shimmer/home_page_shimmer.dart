import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/widget/shapes.dart';

class HomePageShimmerWidget extends StatelessWidget {
  const HomePageShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                ShimmerShapes.circle(50),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerShapes.line(width: 80, height: 12),
                    const SizedBox(height: 8),
                    ShimmerShapes.line(width: 120, height: 12),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),

            ShimmerShapes.box(height: 80),
            const SizedBox(height: 20),

            ShimmerShapes.box(height:350),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerShapes.line(width: 160, height: 16),
                ShimmerShapes.line(width: 50, height: 16),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: ShimmerShapes.box(height: 100)),
                const SizedBox(width: 12),
                Expanded(child: ShimmerShapes.box(height: 100)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: ShimmerShapes.box(height: 100)),
                const SizedBox(width: 12),
                Expanded(child: ShimmerShapes.box(height: 100)),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerShapes.line(width: 180, height: 16),
                ShimmerShapes.line(width: 60, height: 16),
              ],
            ),
            const SizedBox(height: 20),

            ShimmerShapes.box(height: 180),
          ],
        ),
      ),
    );
  }
}

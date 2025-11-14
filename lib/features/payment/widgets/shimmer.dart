import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/widget/shapes.dart';

class PaymentShimmer extends StatelessWidget {
  const PaymentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.transparent,
      unselectedLabelColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      tabs: [
        _shimmerTabBox(),
        _shimmerTabBox(),
      ],
    );
  }

  /// Single shimmer tab box (same UI layout as your actual tab)
  Widget _shimmerTabBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 11, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer ("Received Payment / Pending payment")
            ShimmerShapes.line(
              width: 130,
              height: 16,
            ),

            const SizedBox(height: 12),

            // Amount shimmer
            Row(
              children: [
                ShimmerShapes.circle(20),
                const SizedBox(width: 10),
                ShimmerShapes.line(
                  width: 70,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

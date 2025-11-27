import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/custom_rate_chart.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/glass_container.dart';

class PerformanceSnapshotWidget extends StatelessWidget {
  final List<dynamic> performanceData;
  const PerformanceSnapshotWidget({super.key, this.performanceData = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 233, 193, 235),
            Color.fromARGB(255, 233, 238, 212),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Performance Snapshot",
                    style: AppFonts.subheading),
                const SizedBox(height: 12),

                /// MAIN ROW
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double totalHeight =
                        constraints.maxWidth * 0.75; // Control total height

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// LEFT BIG CARD
                        Expanded(
                          child: ElevatedGlassBox(
                            borderRadius: 12,
                            margin: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              height: totalHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text("Overview",
                                        style: AppFonts.semiratechart),
                                    const SizedBox(height: 4),
                                    Text(
                                      "You have ${performanceData.isNotEmpty ? performanceData[0]["PendingCases"] : "0"} Pending Cases",
                                      style: AppFonts.textred,
                                    ),
                                      const SizedBox(height:20),
                                    CustomRateChart(
                                      completionRate:
                                          performanceData.isNotEmpty
                                              ? double.parse(
                                                  performanceData[0]
                                                          ["Percentage"]
                                                      .toString())
                                              : 0,
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: Text(
                                        "Keep it up! You're ahead of ${performanceData.isNotEmpty ? performanceData[0]["ReviewerPercentile"].toString() : "0"}% of doctors.",
                                        style: AppFonts.subtext
                                            .copyWith(fontSize: 12),
                                            textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// RIGHT SIDE = 2 CARDS
                        Expanded(
                          child: SizedBox(
                            height: totalHeight,
                            child: Column(
                              children: [
                                Expanded(
                                  child: _buildSmallCard(
                                    icon: "assets/svg/time_svg.svg",
                                    title: "Avg. Response Time",
                                    value: performanceData.isNotEmpty
                                        ? performanceData[0]
                                                ["AvgResponseTime"]
                                            .toString()
                                        : "0 hrs",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: _buildSmallCard(
                                    icon:
                                        "assets/svg/earningg_svg.svg",
                                    title: "Total Earnings",
                                    value: performanceData.isNotEmpty
                                        ? performanceData[0]
                                                ["TotalEarnings"]
                                            .toString()
                                        : "0.0",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// RIGHT SMALL CARDS WIDGET
  Widget _buildSmallCard({
    required String icon,
    required String title,
    required String value,
  }) {
    return ElevatedGlassBox(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.white.withAlpha(3),
                AppColors.white.withAlpha(2),
              ],
            ),
            border: Border.all(
              color: AppColors.white.withAlpha(4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon),
              const Spacer(),
              Text(title, style: AppFonts.subtext),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

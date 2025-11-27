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
        gradient: LinearGradient(
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
                Text("Performance Snapshot", style: AppFonts.subheading),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ElevatedGlassBox(
                        borderRadius: 12,
                        margin: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Overview", style: AppFonts.semiratechart),
                                const SizedBox(height: 4),
                                Text(
                                  "You have ${performanceData.isNotEmpty ? performanceData[0]["PendingCases"] : "0"} Pending Cases",
                                  style: AppFonts.textred,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                CustomRateChart(
                                  completionRate:
                                      performanceData.isNotEmpty
                                          ? double.parse(
                                            performanceData[0]["Percentage"]
                                                .toString(),
                                          )
                                          : 0,
                                ),
                                Center(
                                  child: Text(
                                    "Keep it up! You're ahead of 0% of doctors.",
                                    style: AppFonts.subtext.copyWith(
                                      fontSize: 12,
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          ElevatedGlassBox(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.white.withAlpha(3),
                                        AppColors.white.withAlpha(2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/time_svg.svg",
                                      ),
                                      Spacer(),
                                      Text(
                                        "Avg. Response Time",
                                        style: AppFonts.subtext,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        performanceData.isNotEmpty
                                            ? performanceData[0]["AvgResponseTime"]
                                                .toString()
                                            : "0 hrs",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedGlassBox(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withAlpha(3),
                                        Colors.white.withAlpha(2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withAlpha(4),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/earningg_svg.svg",
                                      ),
                                      Spacer(),
                                      Text(
                                        "Total Earnings",
                                        style: AppFonts.semiratechart,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        performanceData.isNotEmpty
                                            ? performanceData[0]["TotalEarnings"]
                                                .toString()
                                            : "0.0",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:ui'; // for BackdropFilter blur
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// class PerformanceSnapshot extends StatelessWidget {
//   const PerformanceSnapshot({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(
//           center: Alignment.topLeft,
//           radius: 1.4,
//           colors: [
//             Color(0xFFFFEAF5), 
//             Color(0xFFF2EDFF), 
//           ],
//         ),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Performance Snapshot", style: AppFonts.subheading),
//           const SizedBox(height: 20),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: GlassContainer(
//                   height: 286,
//                   margin: const EdgeInsets.only(right: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Overview", style: AppFonts.semiratechart),
//                       const SizedBox(height: 4),
//                       Text("You have 3 Pending Cases", style: AppFonts.textred),
//                       const SizedBox(height: 16),

//                       // 🔵 Example placeholder chart — replace with your CustomRateChart()
//                       Center(
//                         child: SizedBox(
//                           width: 100,
//                           height: 100,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               CircularProgressIndicator(
//                                 value: 0.86,
//                                 strokeWidth: 10,
//                                 backgroundColor: Colors.grey[200],
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.indigo.shade400,
//                                 ),
//                               ),
//                               const Text(
//                                 "86%",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Colors.indigo,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       const Text(
//                         "18 completed out of 21 assigned",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       const Text(
//                         "Keep it up! You’re ahead of 75% of doctors.",
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.black54,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // RIGHT COLUMN — Avg. Response Time + Earnings
//               Expanded(
//                 child: Column(
//                   children: [
//                     GlassContainer(
//                       height: 145,
//                       margin: const EdgeInsets.only(bottom: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.timer_outlined,
//                                   color: Colors.indigo.shade400, size: 22),
//                               const SizedBox(width: 6),
//                               Text(
//                                 "Avg. Response Time",
//                                 style: AppFonts.semiratechart,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                             "1h 15m",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     GlassContainer(
//                       height: 130,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.account_balance_wallet_outlined,
//                                   color: Colors.indigo.shade400, size: 22),
//                               const SizedBox(width: 6),
//                               Text(
//                                 "Total Earnings",
//                                 style: AppFonts.semiratechart,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                             "\$150.31",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GlassContainer extends StatelessWidget {
//   final Widget child;
//   final double? height;
//   final EdgeInsetsGeometry? margin;

//   const GlassContainer({
//     super.key,
//     required this.child,
//     this.height,
//     this.margin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: margin,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white.withOpacity(0.3),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }

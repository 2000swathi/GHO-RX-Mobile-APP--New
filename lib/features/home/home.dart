// import 'package:flutter/material.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/common_container.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/reusable_button.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
// import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: CaseAppBar(title: "HELLO"),
//         body: Column(
//           children: [
//             Container(
//               height: 42,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0xffFFF8E6),
//                 border: Border.all(color: Color(0xffF6E3B3), width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 40),

//                     child: Text(
//                       "Profile Verification Pending",
//                       style: AppFonts.textblue.copyWith(
//                         fontFamily: 'Roboto',
//                         color: Color(0xff983C3C),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 16.67,
//                     height: 16.67,
//                     decoration: BoxDecoration(
//                       color: Color(0xffFFF8E6),
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Color(0xff983C3C), width: 1.5),
//                     ),
//                     child: Icon(
//                       Icons.priority_high,
//                       color: Color(0xff983C3C),
//                       size: 10,
//                     ),
//                   ),
//                   Text(
//                     style: AppFonts.textappbar.copyWith(
//                       fontFamily: 'Roboto Flex',
//                       color: Color(0xffAA5757),
//                     ),
//                     "Your profile is currently under review by a GHO administrator.\nWe will notify you when it is approved.",
//                   ),
//                 ],
//               ),
//             ),

//             Text(
//               "Key Performance Indicators",
//               style: AppFonts.subtext.copyWith(
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Roboto',
//                 fontSize: 16,
//               ),
//             ),
//             Row(
//               children: [
//                 CommonContainer(
//                   borderColor: Color(0xff667EFA).withAlpha(33),
//                   color: Color(0xff667EFA0D).withAlpha(5),
//                   textColor: Color(0xff384EC1),
//                   data: "Second Opinion",
//                   data1: "17",
//                   data2: "vs last period",
//                 ),

//                 CommonContainer(
//                   borderColor: Color(0xffFF8A65).withAlpha(48),
//                   color: Color(0xffFF8A651A).withAlpha(10),
//                   textColor: Color(0xffB93106),
//                   data: "Total Consults",
//                   data1: "3",
//                   data2: "vs last period",
//                 ),
//               ],
//             ),

//             Row(
//               children: [
//                 CommonContainer(
//                   borderColor: Color(0xffC5EFC8),
//                   color: Color(0xffF1FFF2),
//                   textColor: Color(0xff146B1A),
//                   data: "Total Revenue",
//                   data1: "150",
//                   data2: "vs last period",
//                 ),
//                 CommonContainer(
//                   borderColor: Color(0xffCCCDCD),
//                   color: Color(0xffF4F5F7),
//                   textColor: Color(0xff404040).withAlpha(48),
//                   data: "Next Payout",
//                   data1: "80",
//                   data2: "vs last period",
//                 ),
//               ],
//             ),
//             Text(
//               "New Second Opinion Request",
//               style: AppFonts.subheading.copyWith(fontSize: 16),
//             ),
//             Container(
//               // height: 222,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 boxShadow: [BoxShadow(color: Color(0xff667EFA).withAlpha(5))],
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   width: 1,
//                   color: Color(0xff667EFA).withAlpha(80),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Text("Case Identifier"),
//                           Text("GHO-2024-9481"),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Text("Allotted Time: 5hrs"),
//                           Text("Due Date: Oct 9, 2024"),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "34-year-old female presenting with acute chest pain, \nradiating to left arm. Requesting urgent cardiologist \nopinion. ",
//                   ),
//                   Row(
//                     children: [
//                       ReusableBtn(
//                         btnName: "Accept Case",
//                         onTap: () {},
//                         bgColor: Color(0xff667EFA),
//                         textColor: Color(0xffFFFFFF),
//                       ),
//                       ReusableBtn(
//                         btnName: "Deny",
//                         onTap: () {},
//                         bgColor: Color(0xff667EFA).withAlpha(15),
//                         textColor: Color(0xff667EFA),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

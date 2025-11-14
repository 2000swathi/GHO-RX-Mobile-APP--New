// import 'package:flutter/material.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// class PaymentAppbar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;
//   final PreferredSizeWidget? tabBar;
//   const PaymentAppbar({super.key, required this.height, required this.tabBar});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,

//       centerTitle: false,
//       titleSpacing: 10,
//       toolbarHeight: height, // 👈 Forces your custom height

//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Earnings", style: AppFonts.heading),
//           SizedBox(height: 28),
//           Text("Reviewer Earnings Dashboard", style: AppFonts.subheading16),
//           SizedBox(height: 16),
//         ],
//       ),
//       bottom: tabBar,
//     );
//   }

//   // 👇 This is what makes it valid for `Scaffold.appBar`
//   @override
//   Size get preferredSize =>
//       Size.fromHeight(height + (tabBar?.preferredSize.height ?? 0));
// }

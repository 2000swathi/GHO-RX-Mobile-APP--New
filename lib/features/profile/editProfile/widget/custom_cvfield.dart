// import 'package:flutter/material.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// class CustomCVUpload extends StatefulWidget {
//   final String label;
//   final Function()? onUploadPressed;
//   final String? fileName;
//   final Function(String)? validator;


//   const CustomCVUpload({
//     super.key,
//     required this.label,
//     this.onUploadPressed,
//     this.fileName,
//     this.validator,
//   });

//   @override
//   State<CustomCVUpload> createState() => _CustomCVUploadState();
// }

// class _CustomCVUploadState extends State<CustomCVUpload> {
//   @override
//   Widget build(BuildContext context) {
//     Color borderColor = AppColors.offgreycolor;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: AppFonts.textSecondary,
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: 380,
//           height: 50,
//           decoration: BoxDecoration(
//             border: Border.all(color: borderColor),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   widget.fileName ?? "No files attached",
//                   style: AppFonts.hinttext,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               VerticalDivider(
//                 width: 1,
//                 color: AppColors.offgreycolor,
//                 thickness: 1,
//                 indent: 14,
//                 endIndent: 14,
//               ),
//               InkWell(
//                 onTap: widget.onUploadPressed,
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//                 child: Container(
//                   width: 90,
//                   alignment: Alignment.center,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         "Upload",
//                         style: AppFonts.textSecondary,
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.drive_folder_upload_outlined,
//                         size: 18,
//                         color: AppColors.hint1color,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

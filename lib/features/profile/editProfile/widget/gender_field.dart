// import 'package:flutter/material.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// class CustomRadioField<T> extends StatelessWidget {
//   final String label;
//   final List<T> options;
//   final T? selectedValue;
//   final ValueChanged<T> onChanged;
//   final String Function(T)? labelBuilder;
//   final FormFieldValidator<T>? validator;

//   const CustomRadioField({
//     Key? key,
//     required this.label,
//     required this.options,
//     required this.selectedValue,
//     required this.onChanged,
//     this.labelBuilder,
//     this.validator,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FormField<T>(
//       validator: validator,
//       builder: (FormFieldState<T> fieldState) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: AppFonts.textSecondary,
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 20,
//               children: options.map((option) {
//                 final optionLabel = labelBuilder != null
//                     ? labelBuilder!(option)
//                     : option.toString();
//                 return Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Radio<T>(
//                       value: option,
//                       groupValue: selectedValue,
//                       activeColor: AppColors.primarycolor,
//                       onChanged: (val) {
//                         onChanged(option);
//                         fieldState.didChange(option);
//                       },
//                     ),
//                     Text(
//                       optionLabel,
//                       style: AppFonts.textSecondary,
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//             if (fieldState.hasError)
//               Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Text(
//                   fieldState.errorText!,
//                   style: const TextStyle(
//                     color: AppColors.warningred,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

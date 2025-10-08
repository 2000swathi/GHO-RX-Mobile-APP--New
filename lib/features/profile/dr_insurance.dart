// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
// import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
// import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_event.dart';
// import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_state.dart';

// import 'bloc/profile_bloc.dart';
// import 'repository/Profile_repo.dart';

// class DrInsurance extends StatelessWidget {
//   const DrInsurance({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final repository = ProfileRepository();

//     return BlocProvider(
//       create: (_) => ProfileBloc(repository: repository)..add(FetchInsurance()),
//       child: Scaffold(
//         appBar: CaseAppBar(title: "Insurance"),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: BlocBuilder<ProfileBloc, ProfileState>(
//             builder: (context, state) {
//               if (state is ProfileLoading) {
//                 return const Center(child: LoadingAnimation());
//               } else if (state is InsuranceState) {
//                 final insuranceList = state.insuranceModel.data;

//                 if (insuranceList.isEmpty) {
//                   return const Center(child: Text("No Insurance added"));
//                 }

//                 return ListView.builder(
//                   itemCount: insuranceList.length,
//                   itemBuilder: (context, index) {
//                     final insurance = insuranceList[index];
//                     return Card(
//                       color: AppColors.primarycolor,
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildRow(
//                               "ProviderID",
//                               insurance.providerID.toString(),
//                             ),
//                             _buildRow(
//                               "ProviderName",
//                               insurance.providerName.toString(),
//                             ),
//                             _buildRow("IssueDate", "${insurance.issueDate}"),
//                             _buildRow("ExpiryDate", "${insurance.expiryDate}"),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is ProfileError) {
//                 return Center(child: Text("Error: ${state.message}"));
//               }
//               return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     final displayValue = (value == null || value.isEmpty) ? "-" : value;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               "$label:",
//               style: AppFonts.subtext.copyWith(color: AppColors.white),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               displayValue,
//               style: AppFonts.subtext.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

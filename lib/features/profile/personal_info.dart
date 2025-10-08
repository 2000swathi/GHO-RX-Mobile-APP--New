// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
// import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
// import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
// import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_bloc.dart';
// import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_event.dart';
// import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_state.dart';

// import 'repository/Profile_repo.dart';

// class PersonalInfoScreen extends StatelessWidget {
//   const PersonalInfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final repository = ProfileRepository();

//     return BlocProvider(
//       create:
//           (_) => ProfileBloc(repository: repository)..add(FetchPersonalInfo()),
//       child: Scaffold(
//         appBar: CaseAppBar(title: "Profile Detailes"),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, state) {
//                   if (state is ProfileLoading) {
//                     return const Center(child: LoadingAnimation());
//                   } else if (state is PersonalInfoState) {
//                     final info = state.personalInfomodel;
//                     return ListView(
//                       shrinkWrap: true,
//                       children: [
//                         _buildRow(
//                           "Full Name",
//                           "${info.firstName} ${info.lastName}",
//                         ),
//                         _buildRow("Email", info.email),
//                         _buildRow("Phone", info.phone),
//                         _buildRow("Country", info.countryName),
//                         _buildRow(
//                           "Address",
//                           "${info.address1} ${info.address2} ${info.city}${info.state}",
//                         ),

//                         _buildRow("Zip Code", info.zipCode),
//                         _buildRow("Birth Date", info.birthDate),
//                       ],
//                     );
//                   } else if (state is ProfileError) {
//                     return Center(child: Text("Error: ${state.message}"));
//                   }
//                   return Container();
//                 },
//               ),
//               // specialty
//               Divider(color: AppColors.primarycolor),
//               BlocProvider(
//                 create:
//                     (_) =>
//                         ProfileBloc(repository: repository)
//                           ..add(FetchSpecialty()),
//                 child: BlocBuilder<ProfileBloc, ProfileState>(
//                   builder: (context, state) {
//                     if (state is ProfileLoading) {
//                       return const Center(child: LoadingAnimation());
//                     } else if (state is SpecialtyState) {
//                       final specialtyList = state.specialtyModel.data;

//                       if (specialtyList.isEmpty) {
//                         return const Center(
//                           child: Text("No specialties found"),
//                         );
//                       }
//                       return Flexible(
//                         child: ListView.builder(
//                           itemCount: specialtyList.length,
//                           itemBuilder: (context, index) {
//                             final specialty = specialtyList[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildRow("Specialty", specialty.specialty),
//                                 _buildRow(
//                                   "Certified Board",
//                                   specialty.certifiedBoard,
//                                 ),
//                                 _buildRow(
//                                   "Specialty Type",
//                                   specialty.specialtyType,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       );
//                     } else if (state is ProfileError) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//               Divider(color: AppColors.primarycolor),
//               BlocProvider(
//                 create:
//                     (_) =>
//                         ProfileBloc(repository: repository)
//                           ..add(FetchLicence()),
//                 child: BlocBuilder<ProfileBloc, ProfileState>(
//                   builder: (context, state) {
//                     if (state is ProfileLoading) {
//                       return const Center(child: LoadingAnimation());
//                     } else if (state is LicenseState) {
//                       final licenseList = state.licenseModel.data;

//                       if (licenseList.isEmpty) {
//                         return const Center(child: Text("No license added"));
//                       }

//                       return Flexible(
//                         child: ListView.builder(
//                           itemCount: licenseList.length,
//                           itemBuilder: (context, index) {
//                             final license = licenseList[index];
//                             return Padding(
//                               padding: const EdgeInsets.all(12),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildRow(
//                                     "License Number",
//                                     license.licenseNumber,
//                                   ),
//                                   _buildRow(
//                                     "Issuing Authority",
//                                     license.issuingAuthority,
//                                   ),
//                                   _buildRow(
//                                     "License Type",
//                                     license.licenseType,
//                                   ),
//                                   _buildRow("Issue Date", license.issueDate),
//                                   _buildRow("Expiry Date", license.expiryDate),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else if (state is ProfileError) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//               Divider(color: AppColors.primarycolor),
//               BlocProvider(
//                 create:
//                     (_) =>
//                         ProfileBloc(repository: repository)
//                           ..add(FetchInsurance()),
//                 child: BlocBuilder<ProfileBloc, ProfileState>(
//                   builder: (context, state) {
//                     if (state is ProfileLoading) {
//                       return const Center(child: LoadingAnimation());
//                     } else if (state is InsuranceState) {
//                       final insuranceList = state.insuranceModel.data;

//                       if (insuranceList.isEmpty) {
//                         return const Center(child: Text("No Insurance added"));
//                       }

//                       return Flexible(
//                         child: ListView.builder(
//                           itemCount: insuranceList.length,
//                           itemBuilder: (context, index) {
//                             final insurance = insuranceList[index];
//                             return Padding(
//                               padding: const EdgeInsets.all(12),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildRow(
//                                     "ProviderID",
//                                     insurance.providerID.toString(),
//                                   ),
//                                   _buildRow(
//                                     "ProviderName",
//                                     insurance.providerName.toString(),
//                                   ),
//                                   _buildRow(
//                                     "IssueDate",
//                                     "${insurance.issueDate}",
//                                   ),
//                                   _buildRow(
//                                     "ExpiryDate",
//                                     "${insurance.expiryDate}",
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else if (state is ProfileError) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     final displayValue = (value.isEmpty || value == "") ? "-" : value;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(flex: 3, child: Text("$label:", style: AppFonts.subtext)),
//           Expanded(
//             flex: 5,
//             child: Text(
//               displayValue,
//               style: AppFonts.subtext.copyWith(fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/addedit_insurance_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/bloc/license_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_specialty_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_bankinfo.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/bloc/language_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/specialty/bloc/specialty_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/profile/widget/profile_appbar_shimmer.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/addedit_insurance_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/license/addedit_license_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/edit_person_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/widget/profiledetails.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ProfileDr extends StatefulWidget {
  const ProfileDr({super.key});

  @override
  State<ProfileDr> createState() => _ProfileDrState();
}

Future<void> _saveEmailToPrefs(String? email) async {
  if (email == null || email.isEmpty) return;

  await SharedPreference.setEmail(email);
}

class _ProfileDrState extends State<ProfileDr> {
  int _expandedIndex = -1;
  @override
  void initState() {
    super.initState();

    // Dispatch events here
    final contextBloc = context.read;

    // contextBloc<ProfileInfoBloc>().add(FetchPersonalInfo());
    contextBloc<SpecialtyBloc>().add(FetchSpecialty());
    contextBloc<InsuranceBloc>().add(FetchInsurance());
    contextBloc<BankInfoBloc>().add(FetchBankInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CaseAppBar(
      //   isLogout: true,
      //   isHome: true,
      //   isappbarHeight: 75,
      //   widgets: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
      //     builder: (context, state) {
      //       if (state is ProfileInfoInitial || state is ProfileInfoLoading) {
      //         return const ProfileAppbarShimmer();
      //       } else if (state is PersonalInfoState) {
      //         final info = state.personalInfomodel;
      //         final email = info.email;
      //         _saveEmailToPrefs(email);

      //         return Column(
      //           children: [
      //             const SizedBox(height: 15),
      //             Row(
      //               children: [
      //                 InkWell(
      //                   onTap: () {
      //                     showDialog(
      //                       context: context,
      //                       builder:
      //                           (context) => ProfileDialog(url: info.imageUrl),
      //                     );
      //                   },
      //                   child: CircleAvatar(
      //                     radius: 25,
      //                     child: CircleAvatar(
      //                       radius: 23,
      //                       backgroundColor: AppColors.profilepink.withAlpha(
      //                         13,
      //                       ),
      //                       child:
      //                           info.imageUrl.isNotEmpty
      //                               ? ClipOval(
      //                                 child: Image.network(
      //                                   info.imageUrl,
      //                                   fit: BoxFit.cover,
      //                                   width: double.infinity,
      //                                   height: double.infinity,
      //                                   loadingBuilder: (
      //                                     context,
      //                                     child,
      //                                     loadingProgress,
      //                                   ) {
      //                                     if (loadingProgress == null) {
      //                                       return child;
      //                                     }

      //                                     return Center(
      //                                       child: SizedBox(
      //                                         height: 15,
      //                                         width: 15,
      //                                         child: CircularProgressIndicator(
      //                                           strokeWidth: 2,
      //                                           valueColor:
      //                                               AlwaysStoppedAnimation<
      //                                                 Color
      //                                               >(AppColors.profilepink),
      //                                         ),
      //                                       ),
      //                                     );
      //                                   },
      //                                   errorBuilder: (
      //                                     context,
      //                                     error,
      //                                     stackTrace,
      //                                   ) {
      //                                     // Fallback if image fails to load
      //                                     return SvgPicture.asset(
      //                                       "assets/svg/person.svg",
      //                                       height: 24,
      //                                       width: 24,
      //                                     );
      //                                   },
      //                                 ),
      //                               )
      //                               : SvgPicture.asset(
      //                                 "assets/svg/person.svg",
      //                                 height: 24,
      //                                 width: 24,
      //                               ),
      //                     ),
      //                   ),
      //                 ),

      //                 const SizedBox(width: 5),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text("Hello", style: AppFonts.textblue),
      //                     SizedBox(height: 5),
      //                     Text(
      //                       "${info.firstName} ${info.lastName}",
      //                       style: AppFonts.subtext.copyWith(
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ],
      //         );
      //       } else if (state is ProfileInfoError) {
      //         return Center(child: Text(state.message));
      //       }
      //       return Center(child: Text("unknown state"));
      //     },
      //   ),
      // ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Take a quick look at your profile and credentials before you continue.",
              style: AppFonts.buttontxt16.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 15),
          //////////////////////////////////////////////////////////person inf0
          // _buildSection(
          //   isadd: false,
          //   index: 0,
          //   heading: "Personal information",
          //   subheading: "View your basic and contact details.",
          //   content: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
          //     builder: (context, state) {
          //       if (state is ProfileInfoLoading) {
          //         return const Center(child: LoadingAnimation());
          //       } else if (state is PersonalInfoState) {
          //         final info = state.personalInfomodel;
          //         return Column(
          //           children: [
          //             _buildRow(
          //               "Full Name",
          //               "${info.firstName} ${info.lastName}",
          //             ),
          //             _buildRow("Birth Date", info.birthDate),
          //             _buildRow("Email", info.email),
          //             _buildRow("Phone", info.phone),
          //             _buildRow("Country", info.countryName),
          //             _buildRow(
          //               "Address",
          //               "${info.address1} ${info.address2} ${info.city} ${info.state}",
          //             ),
          //             _buildRow("Zip Code", info.zipCode),
          //             const SizedBox(height: 15),
          //             Align(
          //               alignment: Alignment.centerRight,
          //               child: BlocListener<ListBloc, ListState>(
          //                 listener: (context, listState) async {
          //                   if (Navigator.canPop(context)) {
          //                     Navigator.pop(context);
          //                   }

          //                   if (listState is CountryState) {
          //                     final countries =
          //                         listState.countryResponse.data
          //                             .expand((inner) => inner)
          //                             .toList();

          //                     Future.microtask(() {
          //                       EditProfileSheet.showSheet(
          //                         context,
          //                         info,
          //                         countries,
          //                       );
          //                     });
          //                     setState(() {
          //                       _expandedIndex = -1;
          //                     });
          //                   } else if (listState is ListFailure) {
          //                     ScaffoldMessenger.of(context).showSnackBar(
          //                       SnackBar(content: Text(listState.error)),
          //                     );
          //                   }
          //                 },
          //                 child: InkWell(
          //                   onTap: () {
          //                     showDialog(
          //                       context: context,
          //                       barrierDismissible: false,
          //                       builder:
          //                           (_) =>
          //                               const Center(child: LoadingAnimation()),
          //                     );

          //                     context.read<ListBloc>().add(FetchCountryList());
          //                   },
          //                   child: SvgPicture.asset("assets/svg/edit_svg.svg"),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       } else if (state is ProfileInfoError) {
          //         return Center(child: Text(state.message));
          //       }
          //       return Container();
          //     },
          //   ),
          // ),

          //////////////////////////////////////////////spl
          _buildSection(
            index: 2,
            heading: "Specialty",
            subheading: "Verify your qualifications and area of expertise.",
            content: BlocListener<DeleteBloc, DeleteState>(
              listener: (context, state) {
                if (state is DeleteLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: LoadingAnimation()),
                  );
                } else if (state is DeleteSuccess) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Specialty deleted successfully",
                  );
                  context.read<SpecialtyBloc>().add(FetchSpecialty());
                } else if (state is DeleteFailure) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Failed to delete specialty",
                  );
                }
              },
              child: BlocBuilder<SpecialtyBloc, SpecialtyState>(
                builder: (context, state) {
                  if (state is SpecialityLoading) {
                    return const Center(child: LoadingAnimation());
                  } else if (state is Specialty) {
                    final specialtyList = state.specialtyModel.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (specialtyList.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("No specialties found"),
                            ),
                          )
                        else
                          ...specialtyList.map(
                            (specialty) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRow("Specialty", specialty.specialty),
                                _buildRow(
                                  "Certified Board",
                                  specialty.certifiedBoard,
                                ),
                                _buildRow(
                                  "Specialty Type",
                                  specialty.specialtyType,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // delete
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          final confirmed =
                                              await showDeleteConfirmationDialog(
                                                context: context,
                                                title: "Delete Specialty",
                                                content:
                                                    "Are you sure want to delete",
                                              );
                                          if (confirmed == true &&
                                              context.mounted) {
                                            context.read<DeleteBloc>().add(
                                              DeleteProfileItem(
                                                id: specialty.id.toString(),
                                                action: "reviewerspl",
                                                isLang: false,
                                              ),
                                            );
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/trash.svg",
                                          // ignore: deprecated_member_use
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    //edit
                                    const SizedBox(width: 15),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder:
                                                (_) => const Center(
                                                  child: LoadingAnimation(),
                                                ),
                                          );

                                          final listBloc =
                                              context.read<ListBloc>();
                                          listBloc.add(FetchSpecialtyList());
                                          listBloc.add(FetchCertifiedList());
                                          listBloc.add(
                                            FetchSpecialtyTypeList(),
                                          );

                                          final results = await Future.wait([
                                            listBloc.stream.firstWhere(
                                              (s) =>
                                                  s is SpecialtyListState ||
                                                  s is ListFailure,
                                            ),
                                            listBloc.stream.firstWhere(
                                              (s) =>
                                                  s is CertifiedListState ||
                                                  s is ListFailure,
                                            ),
                                            listBloc.stream.firstWhere(
                                              (s) =>
                                                  s is SpecialtyTypeListState ||
                                                  s is ListFailure,
                                            ),
                                          ]);

                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();

                                          final listState = results[0];
                                          final certifiedState = results[1];
                                          final typeState = results[2];

                                          if (listState is SpecialtyListState &&
                                              certifiedState
                                                  is CertifiedListState &&
                                              typeState
                                                  is SpecialtyTypeListState) {
                                            final specialties =
                                                listState.specialtyResponse.data
                                                    .expand((inner) => inner)
                                                    .toList();

                                            final certifiedBoards =
                                                certifiedState
                                                    .certifiedResponse
                                                    .data
                                                    .expand((inner) => inner)
                                                    .toList();

                                            final specialtyTypes =
                                                typeState
                                                    .specialtyTypeResponse
                                                    .data
                                                    .expand((inner) => inner)
                                                    .toList();

                                            AddEditSpecialtySheet.showSheet(
                                              context,
                                              specialty,
                                              specialties,
                                              certifiedBoards,
                                              specialtyTypes,
                                              true,
                                              specBloc:
                                                  context.read<SpecialtyBloc>(),
                                            );
                                          } else {
                                            String errorMessage =
                                                "Failed to load data.";
                                            if (listState is ListFailure) {
                                              errorMessage = listState.error;
                                            } else if (certifiedState
                                                is ListFailure) {
                                              errorMessage =
                                                  certifiedState.error;
                                            }
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(errorMessage),
                                              ),
                                            );
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/edit_svg.svg",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: AppColors.hint2color),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () async {
                              final listBloc = context.read<ListBloc>();
                              listBloc.add(FetchSpecialtyList());
                              listBloc.add(FetchCertifiedList());
                              listBloc.add(FetchSpecialtyTypeList());
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (_) =>
                                        const Center(child: LoadingAnimation()),
                              );

                              final results = await Future.wait([
                                listBloc.stream.firstWhere(
                                  (s) =>
                                      s is SpecialtyListState ||
                                      s is ListFailure,
                                ),
                                listBloc.stream.firstWhere(
                                  (s) =>
                                      s is CertifiedListState ||
                                      s is ListFailure,
                                ),
                                listBloc.stream.firstWhere(
                                  (s) =>
                                      s is SpecialtyTypeListState ||
                                      s is ListFailure,
                                ),
                              ]);

                              Navigator.of(context, rootNavigator: true).pop();

                              final listState = results[0];
                              final certifiedState = results[1];
                              final typeState = results[2];

                              if (listState is SpecialtyListState &&
                                  certifiedState is CertifiedListState &&
                                  typeState is SpecialtyTypeListState) {
                                final specialties =
                                    listState.specialtyResponse.data
                                        .expand((inner) => inner)
                                        .toList();
                                final certifiedBoards =
                                    certifiedState.certifiedResponse.data
                                        .expand((inner) => inner)
                                        .toList();
                                final specialtyTypes =
                                    typeState.specialtyTypeResponse.data
                                        .expand((inner) => inner)
                                        .toList();

                                AddEditSpecialtySheet.showSheet(
                                  context,
                                  null,
                                  specialties,
                                  certifiedBoards,
                                  specialtyTypes,
                                  false,
                                  specBloc: context.read<SpecialtyBloc>(),
                                );
                              } else {
                                String errorMessage = "Failed to load data.";
                                if (listState is ListFailure) {
                                  errorMessage = listState.error;
                                } else if (certifiedState is ListFailure) {
                                  errorMessage = certifiedState.error;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Specialty",
                                  style: AppFonts.textprogressbar.copyWith(
                                    color: AppColors.primarycolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is SpecialityError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
          //////////////////////////////////////////////////////accreditation
          // _buildSection(
          //   index: 1,
          //   heading: "Accreditation",
          //   subheading: "Verify your qualifications and area of expertise.",
          //   content: BlocListener<DeleteBloc, DeleteState>(
          //     listener: (context, state) {
          //       if (state is DeleteLoading) {
          //         showDialog(
          //           context: context,
          //           barrierDismissible: false,
          //           builder: (_) => const Center(child: LoadingAnimation()),
          //         );
          //       } else if (state is DeleteSuccess) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showSuccessMessage(
          //           context,
          //           "Accreditation deleted successfully",
          //         );
          //         context.read<AccreditationBloc>().add(FetchAccreditation());
          //       } else if (state is DeleteFailure) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showSuccessMessage(
          //           context,
          //           "Failed to delete accreditation",
          //         );
          //       }
          //     },
          //     child: BlocBuilder<AccreditationBloc, AccreditationState>(
          //       builder: (context, state) {
          //         if (state is AccrediationLoading) {
          //           return const Center(child: LoadingAnimation());
          //         } else if (state is AccreditationgetState) {
          //           final accreditationList = state.accreditationModel.data;
          //           return Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               if (accreditationList.isEmpty)
          //                 const Center(
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 10),
          //                     child: Text("No accreditations found"),
          //                   ),
          //                 ),

          //               ...accreditationList.map((accreditation) {
          //                 return Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     _buildRow(
          //                       "Accreditation number",
          //                       accreditation.accreditationNumber,
          //                     ),
          //                     _buildRow(
          //                       "Accreditation Type",
          //                       accreditation.accreditationType,
          //                     ),
          //                     _buildRow(
          //                       "Accreditation Body",
          //                       accreditation.accreditationBody,
          //                     ),
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               final confirmed =
          //                                   await showDeleteConfirmationDialog(
          //                                     context: context,
          //                                     title: "Delete Accreditation",
          //                                     content:
          //                                         "Are you sure want to delete",
          //                                   );
          //                               if (confirmed == true &&
          //                                   context.mounted) {
          //                                 context.read<DeleteBloc>().add(
          //                                   DeleteProfileItem(
          //                                     id: accreditation.id.toString(),
          //                                     action: "revieweraccred",
          //                                     isLang: false,
          //                                   ),
          //                                 );
          //                               }
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/trash.svg",
          //                               color: Colors.red,
          //                             ),
          //                           ),
          //                         ),

          //                         const SizedBox(width: 15),
          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               final listBloc =
          //                                   context.read<ListBloc>();
          //                               listBloc.add(FetchAccrediationList());

          //                               showDialog(
          //                                 context: context,
          //                                 barrierDismissible: false,
          //                                 builder:
          //                                     (_) => const Center(
          //                                       child: LoadingAnimation(),
          //                                     ),
          //                               );

          //                               final listState = await listBloc.stream
          //                                   .firstWhere(
          //                                     (s) =>
          //                                         s is AccreditationTypeListState ||
          //                                         s is ListFailure,
          //                                   );

          //                               Navigator.pop(context);

          //                               if (listState
          //                                   is AccreditationTypeListState) {
          //                                 final accreditationTypeList =
          //                                     listState
          //                                         .accreditationTypeResponse
          //                                         .data;

          //                                 AddEditAccrediationBottomSheet.showSheet(
          //                                   context,
          //                                   accreditation,
          //                                   true,
          //                                   accrBloc:
          //                                       context
          //                                           .read<AccreditationBloc>(),
          //                                   accreList: accreditationTypeList,
          //                                 );
          //                               } else if (listState is ListFailure) {
          //                                 ScaffoldMessenger.of(
          //                                   context,
          //                                 ).showSnackBar(
          //                                   SnackBar(
          //                                     content: Text(listState.error),
          //                                   ),
          //                                 );
          //                               }
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/edit_svg.svg",
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Divider(color: AppColors.hint2color),
          //                   ],
          //                 );
          //               }),

          //               const SizedBox(height: 10),
          //               Align(
          //                 alignment: Alignment.centerRight,
          //                 child: InkWell(
          //                   onTap: () async {
          //                     final listBloc = context.read<ListBloc>();
          //                     listBloc.add(FetchAccrediationList());

          //                     showDialog(
          //                       context: context,
          //                       barrierDismissible: false,
          //                       builder:
          //                           (_) =>
          //                               const Center(child: LoadingAnimation()),
          //                     );

          //                     final listState = await listBloc.stream
          //                         .firstWhere(
          //                           (s) =>
          //                               s is AccreditationTypeListState ||
          //                               s is ListFailure,
          //                         );

          //                     Navigator.pop(context);

          //                     if (listState is AccreditationTypeListState) {
          //                       final accreditationTypeList =
          //                           listState.accreditationTypeResponse.data;

          //                       AddEditAccrediationBottomSheet.showSheet(
          //                         context,
          //                         null,
          //                         false,
          //                         accrBloc: context.read<AccreditationBloc>(),
          //                         accreList: accreditationTypeList,
          //                       );
          //                     } else if (listState is ListFailure) {
          //                       ScaffoldMessenger.of(context).showSnackBar(
          //                         SnackBar(content: Text(listState.error)),
          //                       );
          //                     }
          //                   },
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Text(
          //                         "Add Accreditation",
          //                         style: AppFonts.textprogressbar.copyWith(
          //                           color: AppColors.primarycolor,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         } else if (state is AccrediationError) {
          //           return Center(child: Text(state.message));
          //         }
          //         return Container();
          //       },
          //     ),
          //   ),
          // ),
          _buildSection(
            index: 3,
            heading: "Insurance",
            subheading: "Review your professional coverage details.",
            content: BlocListener<DeleteBloc, DeleteState>(
              listener: (context, state) {
                if (state is DeleteLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: LoadingAnimation()),
                  );
                } else if (state is DeleteSuccess) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Insurance deleted successfully",
                  );
                  context.read<InsuranceBloc>().add(FetchInsurance());
                } else if (state is DeleteFailure) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Failed to delete insurance",
                  );
                }
              },
              child: BlocBuilder<InsuranceBloc, InsuranceState>(
                builder: (context, state) {
                  if (state is InsuranceLoading) {
                    return const Center(child: LoadingAnimation());
                  } else if (state is InsuranceGetState) {
                    final insuranceList = state.insuranceModel.data;
                    return Column(
                      children: [
                        if (insuranceList.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No Insurance found"),
                            ),
                          )
                        else
                          ...insuranceList.map(
                            (insurance) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRow(
                                  "ProviderID",
                                  insurance.providerID.toString(),
                                ),
                                _buildRow(
                                  "ProviderName",
                                  insurance.providerName.toString(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          final confirmed =
                                              await showDeleteConfirmationDialog(
                                                context: context,
                                                title: "Delete Insurance",
                                                content:
                                                    "Are you sure want to delete",
                                              );
                                          if (confirmed == true &&
                                              context.mounted) {
                                            context.read<DeleteBloc>().add(
                                              DeleteProfileItem(
                                                id: insurance.id.toString(),
                                                action: "reviewerins",
                                                isLang: false,
                                              ),
                                            );
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/trash.svg",
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          AddEditInsuranceSheet.showSheet(
                                            context,
                                            insurance,
                                            true,
                                            insuranceBloc:
                                                context.read<InsuranceBloc>(),
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/edit_svg.svg",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: AppColors.hint2color),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              AddEditInsuranceSheet.showSheet(
                                context,
                                null,
                                false,
                                insuranceBloc: context.read<InsuranceBloc>(),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Insurance",
                                  style: AppFonts.textprogressbar.copyWith(
                                    color: AppColors.primarycolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is InsuranceError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
          // _buildSection(
          //   index: 4,
          //   heading: "License",
          //   subheading:
          //       "Check your official authorization to practice medicine.",
          //   content: BlocListener<DeleteBloc, DeleteState>(
          //     listener: (context, state) {
          //       if (state is DeleteLoading) {
          //         showDialog(
          //           context: context,
          //           barrierDismissible: false,
          //           builder: (_) => const Center(child: LoadingAnimation()),
          //         );
          //       } else if (state is DeleteSuccess) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showSuccessMessage(
          //           context,
          //           "License deleted successfully",
          //         );
          //         context.read<LicenseBloc>().add(FetchLicense());
          //       } else if (state is DeleteFailure) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showErrorMessage(
          //           context,
          //           "Failed to delete license",
          //         );
          //       }
          //     },
          //     child: BlocBuilder<LicenseBloc, LicenseState>(
          //       builder: (context, state) {
          //         if (state is LicenseLoading) {
          //           return const Center(child: LoadingAnimation());
          //         } else if (state is Licensegetsuccess) {
          //           final licenseList = state.licenseModel.data;

          //           return Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               if (licenseList.isEmpty)
          //                 const Center(
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 10),
          //                     child: Text("No licenses found"),
          //                   ),
          //                 ),

          //               ...licenseList.map((license) {
          //                 return Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     _buildRow(
          //                       "License Number",
          //                       license.licenseNumber,
          //                     ),
          //                     _buildRow("License Type", license.licenseType),
          //                     _buildRow(
          //                       "Issuing Authority",
          //                       license.issuingAuthority,
          //                     ),

          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               final confirmed =
          //                                   await showDeleteConfirmationDialog(
          //                                     context: context,
          //                                     title: "Delete License",
          //                                     content:
          //                                         "Are you sure you want to delete?",
          //                                   );
          //                               if (confirmed == true &&
          //                                   context.mounted) {
          //                                 context.read<DeleteBloc>().add(
          //                                   DeleteProfileItem(
          //                                     id: license.id.toString(),
          //                                     action: "reviewerlic",
          //                                     isLang: false,
          //                                   ),
          //                                 );
          //                               }
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/trash.svg",
          //                               // ignore: deprecated_member_use
          //                               color: Colors.red,
          //                             ),
          //                           ),
          //                         ),

          //                         const SizedBox(width: 15),

          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               showDialog(
          //                                 context: context,
          //                                 barrierDismissible: false,
          //                                 builder:
          //                                     (_) => const Center(
          //                                       child: LoadingAnimation(),
          //                                     ),
          //                               );

          //                               final listBloc =
          //                                   context.read<ListBloc>();
          //                               listBloc.add(FetchLicenseList());
          //                               listBloc.add(
          //                                 FetchIssueingAuthorityList(),
          //                               );

          //                               final results = await Future.wait([
          //                                 listBloc.stream.firstWhere(
          //                                   (s) =>
          //                                       s is LicenseListState ||
          //                                       s is ListFailure,
          //                                 ),
          //                                 listBloc.stream.firstWhere(
          //                                   (s) =>
          //                                       s is IssueingauthorityListState ||
          //                                       s is ListFailure,
          //                                 ),
          //                               ]);

          //                               // final listState = await listBloc
          //                               //     .stream
          //                               //     .firstWhere(
          //                               //       (s) =>
          //                               //           s is LicenseListState ||
          //                               //           s is ListFailure,
          //                               //     );

          //                               Navigator.of(
          //                                 context,
          //                                 rootNavigator: true,
          //                               ).pop();

          //                               final listState = results[0];
          //                               final issueingstate = results[1];

          //                               if (listState is LicenseListState &&
          //                                   issueingstate
          //                                       is IssueingauthorityListState) {
          //                                 final licenses =
          //                                     listState.licenseResponse.data
          //                                         .expand((inner) => inner)
          //                                         .toList();
          //                                 final issueingList =
          //                                     issueingstate
          //                                         .issueingauthorityResponse
          //                                         .data
          //                                         .expand((inner) => inner)
          //                                         .toList();

          //                                 AddEditLicenseSheet.showSheet(
          //                                   context,
          //                                   license,
          //                                   licenses,
          //                                   issueingList,
          //                                   true,
          //                                   licenseBloc:
          //                                       context.read<LicenseBloc>(),
          //                                 );
          //                               } else if (listState is ListFailure) {
          //                                 ScaffoldMessenger.of(
          //                                   context,
          //                                 ).showSnackBar(
          //                                   SnackBar(
          //                                     content: Text(listState.error),
          //                                   ),
          //                                 );
          //                               }
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/edit_svg.svg",
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Divider(color: AppColors.hint2color),
          //                   ],
          //                 );
          //               }),
          //               SizedBox(height: 10),
          //               Align(
          //                 alignment: Alignment.centerRight,
          //                 child: InkWell(
          //                   onTap: () async {
          //                     final listBloc = context.read<ListBloc>();
          //                     listBloc.add(FetchLicenseList());
          //                     listBloc.add(FetchIssueingAuthorityList());

          //                     showDialog(
          //                       context: context,
          //                       barrierDismissible: false,
          //                       builder:
          //                           (_) =>
          //                               const Center(child: LoadingAnimation()),
          //                     );

          //                     final licenseState = await listBloc.stream
          //                         .firstWhere(
          //                           (s) =>
          //                               s is LicenseListState ||
          //                               s is ListFailure,
          //                         );
          //                     final issueingstate = await listBloc.stream
          //                         .firstWhere(
          //                           (s) =>
          //                               s is IssueingauthorityListState ||
          //                               s is ListFailure,
          //                         );

          //                     Navigator.pop(context);

          //                     if (licenseState is LicenseListState &&
          //                         issueingstate is IssueingauthorityListState) {
          //                       final licenses =
          //                           licenseState.licenseResponse.data
          //                               .expand((inner) => inner)
          //                               .toList();
          //                       final issueingList =
          //                           issueingstate.issueingauthorityResponse.data
          //                               .expand((inner) => inner)
          //                               .toList();

          //                       AddEditLicenseSheet.showSheet(
          //                         context,
          //                         null,
          //                         licenses,
          //                         issueingList,
          //                         false,
          //                         licenseBloc: context.read<LicenseBloc>(),
          //                       );
          //                     } else if (licenseState is ListFailure) {
          //                       ScaffoldMessenger.of(context).showSnackBar(
          //                         SnackBar(content: Text(licenseState.error)),
          //                       );
          //                     }
          //                   },
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Text(
          //                         "Add License",
          //                         style: AppFonts.textprogressbar.copyWith(
          //                           color: AppColors.primarycolor,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         } else if (state is LicenseError) {
          //           return Center(child: Text(state.message));
          //         }
          //         return Container();
          //       },
          //     ),
          //   ),
          // ),

          // _buildSection(
          //   index: 5,
          //   heading: "Language",
          //   subheading: "Choose your Language and proficiency",

          //   content: BlocListener<DeleteBloc, DeleteState>(
          //     listener: (context, state) {
          //       if (state is DeleteLoading) {
          //         showDialog(
          //           context: context,
          //           barrierDismissible: false,
          //           builder: (_) => const Center(child: LoadingAnimation()),
          //         );
          //       } else if (state is DeleteSuccess) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showSuccessMessage(
          //           context,
          //           "Language deleted successfully",
          //         );
          //         context.read<LanguageBloc>().add(FetchLanguage());
          //       } else if (state is DeleteFailure) {
          //         Navigator.pop(context);
          //         CustomScaffoldMessenger.showErrorMessage(
          //           context,
          //           "Failed to delete language",
          //         );
          //       }
          //     },
          //     child: BlocBuilder<LanguageBloc, LanguageState>(
          //       builder: (context, state) {
          //         if (state is LanguageLoading) {
          //           return const Center(child: LoadingAnimation());
          //         }
          //         if (state is Language) {
          //           final languageList = state.languageModel.data;
          //           // if (languageList.isEmpty) {
          //           //   return const Center(child: Text("No language added"));
          //           // }
          //           // final info = state.languageModel;

          //           return Column(
          //             children: [
          //               if (languageList.isEmpty)
          //                 const Center(
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 10),
          //                     child: Text("No language found"),
          //                   ),
          //                 ),
          //               ...languageList.map(
          //                 (language) => Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     _buildRow("Language", language.language),
          //                     _buildRow("Proficiency", language.proficiency),
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               final confirmed =
          //                                   await showDeleteConfirmationDialog(
          //                                     context: context,
          //                                     title: "Delete Language",
          //                                     content:
          //                                         "Are you sure you want to delete?",
          //                                   );
          //                               if (confirmed == true &&
          //                                   context.mounted) {
          //                                 context.read<DeleteBloc>().add(
          //                                   DeleteProfileItem(
          //                                     id: language.id.toString(),
          //                                     action: "reviewerlang",
          //                                     isLang: true,
          //                                   ),
          //                                 );
          //                               }
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/trash.svg",
          //                               // ignore: deprecated_member_use
          //                               color: Colors.red,
          //                             ),
          //                           ),
          //                         ),

          //                         const SizedBox(width: 15),
          //                         Align(
          //                           alignment: Alignment.centerRight,
          //                           child: InkWell(
          //                             onTap: () async {
          //                               AddeditLanguageSheet.showSheet(
          //                                 context,
          //                                 languageList,
          //                                 true,
          //                                 languagebloc:
          //                                     context.read<LanguageBloc>(),
          //                               );
          //                             },
          //                             child: SvgPicture.asset(
          //                               "assets/svg/edit_svg.svg",
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Divider(color: AppColors.hint2color),
          //                   ],
          //                 ),
          //               ),
          //               SizedBox(height: 12),
          //               Align(
          //                 alignment: Alignment.centerRight,
          //                 child: InkWell(
          //                   onTap: () {
          //                     AddeditLanguageSheet.showSheet(
          //                       context,
          //                       languageList,
          //                       false,
          //                       languagebloc: context.read<LanguageBloc>(),
          //                     );
          //                   },
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Text(
          //                         "Add Language",
          //                         style: AppFonts.textprogressbar.copyWith(
          //                           color: AppColors.primarycolor,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         }
          //         if (state is LangugageError) {
          //           return Center(child: Text(state.message));
          //         }
          //         return Container();
          //       },
          //     ),
          //   ),
          // ),
          _buildSection(
            index: 6,
            heading: "Bank Information",
            subheading: "Check your registered bank or payment details.",
            content: BlocListener<DeleteBloc, DeleteState>(
              listener: (context, state) {
                if (state is DeleteLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: LoadingAnimation()),
                  );
                } else if (state is DeleteSuccess) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Bank Information deleted successfully",
                  );
                  context.read<BankInfoBloc>().add(FetchBankInfo());
                } else if (state is DeleteFailure) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showSuccessMessage(
                    context,
                    "Failed to delete Bank Information",
                  );
                }
              },
              child: BlocBuilder<BankInfoBloc, BankInfoState>(
                builder: (context, state) {
                  if (state is BankInfoLoading) {
                    return const Center(child: LoadingAnimation());
                  }
                  if (state is BankInfo) {
                    final bankList = state.bankListModel.data;
                    // if (bankList.isEmpty) {
                    //   return const Center(child: Text("No bank added"));
                    // }
                    final info = state.bankListModel;

                    return Column(
                      children: [
                        if (bankList.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No Bank information found"),
                            ),
                          ),

                        ...bankList.map((bank) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow("Bank Type", bank.accountType),
                              _buildRow("Routing Number", bank.routingNumber),
                              _buildRow("Account Number", bank.accountNumber),
                              _buildRow("Account Name", bank.accountHolderName),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () async {
                                        final confirmed =
                                            await showDeleteConfirmationDialog(
                                              context: context,
                                              title: "Delete Bank information",
                                              content:
                                                  "Are you sure want to delete",
                                            );
                                        if (confirmed == true &&
                                            context.mounted) {
                                          context.read<DeleteBloc>().add(
                                            DeleteProfileItem(
                                              id: bank.id.toString(),
                                              action: "revieweracc",
                                              isLang: false,
                                            ),
                                          );
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svg/trash.svg",
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder:
                                              (_) => const Center(
                                                child: LoadingAnimation(),
                                              ),
                                        );
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop();
                                        AddEditBankInfoBottonSheet.showSheet(
                                          context,
                                          info,
                                          true,
                                          bankinfobloc:
                                              context.read<BankInfoBloc>(),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svg/edit_svg.svg",
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(color: AppColors.hint2color),
                            ],
                          );
                        }),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (_) =>
                                        const Center(child: LoadingAnimation()),
                              );
                              Navigator.pop(context);
                              AddEditBankInfoBottonSheet.showSheet(
                                context,
                                info,
                                false,
                                bankinfobloc: context.read<BankInfoBloc>(),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Bank Info",
                                  style: AppFonts.textprogressbar.copyWith(
                                    color: AppColors.primarycolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is BankInfoError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required int index,
    required String heading,
    required String subheading,
    required Widget content,
    bool? isadd = true,
  }) {
    return ProfileDtlContainer(
      key: ValueKey(heading),
      heading: heading,
      subheading: subheading,
      info: content,
      isExpanded: _expandedIndex == index,
      onTap: () {
        setState(() {
          _expandedIndex = (_expandedIndex == index) ? -1 : index;
        });
      },
    );
  }

  Widget _buildRow(String label, String value) {
    final displayValue = (value.isEmpty) ? "-" : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: AppFonts.textSecondary),
          Flexible(child: Text(displayValue, style: AppFonts.semiratechart)),
        ],
      ),
    );
  }
}

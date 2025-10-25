// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/profile/delete/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_language.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_specialty_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_accreditation_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_bankinfo.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_state.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/profile_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_insurance_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/addedit_license_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/edit_person_sheet.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/widget/profiledetails.dart';

class ProfileDr extends StatefulWidget {
  const ProfileDr({super.key});

  @override
  State<ProfileDr> createState() => _ProfileDrState();
}

class _ProfileDrState extends State<ProfileDr> {
  int _expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final repository = ProfileRepository();

    return Scaffold(
      appBar: CaseAppBar(title: 'Welcome, Doctor', istrue: true),
      body: ListView(
        children: [
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

          _buildSection(
            isadd: false,
            index: 0,
            heading: "Personal information",
            subheading: "View your basic and contact details.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)
                        ..add(FetchPersonalInfo()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: LoadingAnimation());
                  } else if (state is PersonalInfoState) {
                    final info = state.personalInfomodel;
                    return Column(
                      children: [
                        _buildRow(
                          "Full Name",
                          "${info.firstName} ${info.lastName}",
                        ),
                        _buildRow("Birth Date", info.birthDate),
                        _buildRow("Email", info.email),
                        _buildRow("Phone", info.phone),
                        _buildRow("Country", info.countryName),
                        _buildRow(
                          "Address",
                          "${info.address1} ${info.address2} ${info.city} ${info.state}",
                        ),
                        _buildRow("Zip Code", info.zipCode),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerRight,
                          child: BlocListener<ListBloc, ListState>(
                            listener: (context, listState) async {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }

                              if (listState is CountryState) {
                                final countries =
                                    listState.countryResponse.data
                                        .expand((inner) => inner)
                                        .toList();

                                Future.microtask(() {
                                  EditProfileSheet.showSheet(
                                    context,
                                    info,
                                    countries,
                                  );
                                });
                                setState(() {
                                  _expandedIndex = -1;
                                });
                              } else if (listState is ListFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(listState.error)),
                                );
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder:
                                      (_) => const Center(
                                        child: LoadingAnimation(),
                                      ),
                                );

                                context.read<ListBloc>().add(
                                  FetchCountryList(),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/svg/edit_svg.svg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
          _buildSection(
            index: 2,
            heading: "Specialty",
            subheading: "Verify your qualifications and area of expertise.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)
                        ..add(FetchSpecialty()),
              child: BlocListener<DeleteBloc, DeleteState>(
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
                    context.read<ProfileBloc>().add(FetchSpecialty());
                  } else if (state is DeleteFailure) {
                    Navigator.pop(context);
                    CustomScaffoldMessenger.showSuccessMessage(
                      context,
                      "Failed to delete specialty",
                    );
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: LoadingAnimation());
                    } else if (state is SpecialtyState) {
                      final specialtyList = state.specialtyModel.data;
                      if (specialtyList.isEmpty) {
                        return const Center(
                          child: Text("No specialties found"),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

                                          final listBloc = context.read<ListBloc>();
                                          listBloc.add(FetchSpecialtyList());
                                          listBloc.add(FetchCertifiedList());
                                          listBloc.add(FetchSpecialtyTypeList());



                                          final results = await Future.wait([
                                            listBloc.stream.firstWhere((s) => s is SpecialtyListState || s is ListFailure),
                                            listBloc.stream.firstWhere((s) => s is CertifiedListState || s is ListFailure),
                                            listBloc.stream.firstWhere((s) => s is SpecialtyTypeListState || s is ListFailure),
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
                                              typeState is SpecialtyTypeListState) {
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
                                                typeState.specialtyTypeResponse.data
                                                    .expand((inner) => inner)
                                                    .toList();
                                            

                                            AddEditSpecialtySheet.showSheet(
                                              context,
                                              specialty,
                                              specialties,
                                              certifiedBoards,
                                              specialtyTypes,
                                              true,
                                            );
                                          } else {
                                            String errorMessage = "Failed to load data.";
                                            if (listState is ListFailure) {
                                              errorMessage = listState.error;
                                            } else if (certifiedState is ListFailure) {
                                              errorMessage = certifiedState.error;
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

                          // Add Specialty button at the bottom
                          const SizedBox(height: 10),
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

                                final listBloc = context.read<ListBloc>();
                                listBloc.add(FetchSpecialtyList());
                                listBloc.add(FetchCertifiedList());
                                listBloc.add(FetchSpecialtyTypeList());


                                final results = await Future.wait([
                                  listBloc.stream.firstWhere((s) => s is SpecialtyListState || s is ListFailure),
                                  listBloc.stream.firstWhere((s) => s is CertifiedListState || s is ListFailure),
                                  listBloc.stream.firstWhere((s)=> s is SpecialtyTypeListState || s is ListFailure),
                                ]);

                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();

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
                    } else if (state is ProfileError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),

          _buildSection(
            index: 1,
            heading: "Accreditation",
            subheading: "Verify your qualifications and area of expertise.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)
                        ..add(FetchAccreditation()),
              child: BlocListener<DeleteBloc, DeleteState>(
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
                      "Accreditation deleted successfully",
                    );
                    context.read<ProfileBloc>().add(FetchAccreditation());
                  } else if (state is DeleteFailure) {
                    Navigator.pop(context);
                    CustomScaffoldMessenger.showSuccessMessage(
                      context,
                      "Failed to delete accreditation",
                    );
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: LoadingAnimation());
                    } else if (state is AccreditationState) {
                      final accreditationList = state.accreditationModel.data;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (accreditationList.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text("No accreditations found"),
                              ),
                            ),

                          ...accreditationList.map((accreditation) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRow(
                                  "Accreditation number",
                                  accreditation.accreditationNumber,
                                ),
                                _buildRow(
                                  "Accreditation Type",
                                  accreditation.accreditationType,
                                ),
                                _buildRow(
                                  "Accreditation Body",
                                  accreditation.accreditationBody,
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
                                                title: "Delete Accreditation",
                                                content:
                                                    "Are you sure want to delete",
                                              );
                                          if (confirmed == true &&
                                              context.mounted) {
                                            context.read<DeleteBloc>().add(
                                              DeleteProfileItem(
                                                id: accreditation.id.toString(),
                                                action: "revieweraccred",
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
                                        onTap: () {
                                          AddEditAccrediationBottomSheet.showSheet(
                                            context,
                                            accreditation,
                                            true,
                                            profileBloc:
                                                context.read<ProfileBloc>(),
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

                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                AddEditAccrediationBottomSheet.showSheet(
                                  context,
                                  null,
                                  false,
                                  profileBloc: context.read<ProfileBloc>(),
                                );
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder:
                                      (_) => const Center(
                                        child: LoadingAnimation(),
                                      ),
                                );

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Add accreditation not implemented yet.",
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add Accreditation",
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
                    } else if (state is ProfileError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
          _buildSection(
            index: 3,
            heading: "Insurance",
            subheading: "Review your professional coverage details.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)
                        ..add(FetchInsurance()),
              child: BlocListener<DeleteBloc, DeleteState>(
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
                    context.read<ProfileBloc>().add(FetchInsurance());
                  } else if (state is DeleteFailure) {
                    Navigator.pop(context);
                    CustomScaffoldMessenger.showSuccessMessage(
                      context,
                      "Failed to delete insurance",
                    );
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: LoadingAnimation());
                    }
                    if (state is InsuranceState) {
                      final insuranceList = state.insuranceModel.data;
                      return Column(
                        children: [
                          if (insuranceList.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No Insurance found"),
                              ),
                            ),
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
                                            profileBloc:
                                                context.read<ProfileBloc>(),
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
                                  profileBloc: context.read<ProfileBloc>(),
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

                    if (state is ProfileError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
          _buildSection(
            index: 4,
            heading: "License",
            subheading:
                "Check your official authorization to practice medicine.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)..add(FetchLicence()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: LoadingAnimation());
                  }
                  // if (licenseList.isEmpty) {
                  //   return const Center(child: Text("No license added"));
                  // }
                  if (state is LicenseState) {
                    final licenseList = state.licenseModel.data;
                    final info = state.licenseModel;

                    return Column(
                      children: [
                        ...licenseList.map(
                          (license) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow(
                                "License Number",
                                license.licenseNumber,
                              ),
                              _buildRow(
                                "Issuing Authority",
                                license.issuingAuthority,
                              ),
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
                                    context.read<ListBloc>().add(
                                      FetchLicenseList(),
                                    );
                                    final listState = await context
                                        .read<ListBloc>()
                                        .stream
                                        .firstWhere(
                                          (s) =>
                                              s is LicenseListState ||
                                              s is ListFailure,
                                        );
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();

                                    if (listState is LicenseListState) {
                                      final licenses =
                                          listState.licenseResponse.data
                                              .expand((inner) => inner)
                                              .toList();

                                      AddEditLicenseSheet.showSheet(
                                        context,
                                        info,
                                        licenses,
                                        true,
                                      );
                                    } else if (listState is ListFailure) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(listState.error),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      SvgPicture.asset(
                                        "assets/svg/edit_svg.svg",
                                      ),
                                      SizedBox(width: 15),
                                      SvgPicture.asset(
                                        "assets/svg/trash.svg",
                                        color: AppColors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: AppColors.hint2color),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (_) =>
                                        const Center(child: LoadingAnimation()),
                              );

                              context.read<ListBloc>().add(FetchLicenseList());

                              final licenseState = await context
                                  .read<ListBloc>()
                                  .stream
                                  .firstWhere(
                                    (s) =>
                                        s is LicenseListState ||
                                        s is ListFailure,
                                  );

                              Navigator.of(context, rootNavigator: true).pop();

                              if (licenseState is LicenseListState) {
                                final languages =
                                    licenseState.licenseResponse.data
                                        .expand((inner) => inner)
                                        .toList();

                                AddEditLicenseSheet.showSheet(
                                  context,
                                  info,
                                  languages,
                                  false,
                                );
                              } else if (licenseState is ListFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(licenseState.error)),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add License",
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

                  if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),

          _buildSection(
            index: 5,
            heading: "Language",
            subheading: "Choose your Language and proficiency",

            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)..add(FetchLanguage()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: LoadingAnimation());
                  }
                  if (state is LanguageState) {
                    final languageList = state.languageModel.data;
                    if (languageList.isEmpty) {
                      return const Center(child: Text("No license added"));
                    }
                    final info = state.languageModel;
                    return Column(
                      children: [
                        ...languageList.map(
                          (language) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow("Language", language.language),
                              _buildRow("Proficiency", language.proficiency),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async {
                                    AddeditLanguageSheet.showSheet(
                                      context,
                                      info,
                                      true,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/edit_svg.svg",
                                  ),
                                ),
                              ),
                              Divider(color: AppColors.hint2color),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              AddeditLanguageSheet.showSheet(
                                context,
                                info,
                                false,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Language",
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
                  if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ),
          _buildSection(
            index: 6,
            heading: "Bank Information",
            subheading: "Check your registered bank or payment details.",
            content: BlocProvider(
              create:
                  (_) =>
                      ProfileBloc(repository: repository)..add(FetchBankInfo()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: LoadingAnimation());
                  }
                  if (state is BankInfoState) {
                    final bankList = state.bankListModel.data;
                    if (bankList.isEmpty) {
                      return const Center(child: Text("No bank added"));
                    }
                    final info = state.bankListModel;

                    return Column(
                      children: [
                        ...bankList.map((bank) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow("Bank Type", bank.accountType),
                              _buildRow("Routing Number", bank.routingNumber),
                              _buildRow("Account Number", bank.accountNumber),
                              _buildRow("Account Name", bank.accountHolderName),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async {
                                    AddEditBankInfoBottonSheet.showSheet(
                                      context,
                                      info,
                                      true,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/edit_svg.svg",
                                  ),
                                ),
                              ),

                              Divider(color: AppColors.hint2color),
                            ],
                          );
                        }),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              AddEditBankInfoBottonSheet.showSheet(
                                context,
                                info,
                                false,
                              );
                              AddEditBankInfoBottonSheet.showSheet(
                                context,
                                info,
                                false,
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
                  if (state is ProfileError) {
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

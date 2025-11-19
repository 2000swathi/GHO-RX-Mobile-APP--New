import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/edit_person_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/bloc/profile_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  PersonalInfoModel? personalInfo;
  @override
  void initState() {
    super.initState();
    context.read<ProfileInfoBloc>().add(FetchPersonalInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Personal Information", style: AppFonts.heading),
      ),

      body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Center(child: LoadingAnimation());
          } else if (state is ProfileInfoError) {
            return Center(child: Text(state.message));
          } else if (state is PersonalInfoState) {
            personalInfo = state.personalInfomodel;
            final info = personalInfo!;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 47,
                        backgroundColor: AppColors.primarycolor.withAlpha(13),
                        child:
                            (info.imageUrl.isNotEmpty)
                                ? ClipOval(
                                  child: Image.network(
                                    info.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder: (context, child, prog) {
                                      if (prog == null) return child;
                                      return Center(
                                        child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              AppColors.primarycolor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stack) =>
                                            SvgPicture.asset(
                                              "assets/svg/person.svg",
                                            ),
                                  ),
                                )
                                : SvgPicture.asset("assets/svg/person.svg"),
                      ),

                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => ProfileDialog(url: info.imageUrl),
                            );
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.white,
                            child: SvgPicture.asset(
                              "assets/svg/account/edit.svg",
                              height: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  buildInfo("Full Name", "${info.firstName} ${info.lastName}"),
                  buildInfo("Date of Birth", info.birthDate),
                  buildInfo("Email", info.email),
                  buildInfo("Mobile Number", info.phone),
                  buildInfo("Address 1", info.address1),
                  buildInfo("Address 2", info.address2),
                  buildInfo("Country", info.countryName),
                  buildInfo("State", info.state),
                  buildInfo("City", info.city),
                  buildInfo("Zip/Postal Code", info.zipCode),

                  const SizedBox(height: 20),
                ],
              ),
            );
          }

          return Center(child: Text("Invalid State"));
        },
      ),

      floatingActionButton: BlocListener<ListBloc, ListState>(
        listener: (context, listState) async {
          if (listState is CountryState) {
            Navigator.pop(context); // Close loader

            final countries =
                listState.countryResponse.data.expand((e) => e).toList();

            Future.microtask(() {
              EditProfileSheet.showSheet(context, personalInfo!, countries);
            });
          } else if (listState is ListFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(listState.error)));
          }
        },
        child: FloatingActionButton(
          backgroundColor: AppColors.white,
          child: SvgPicture.asset("assets/svg/account/pencil.svg", height: 20),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: LoadingAnimation()),
            );

            context.read<ListBloc>().add(FetchCountryList());
          },
        ),
      ),
    );
  }

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label:", style: AppFonts.hinttext2),
          const SizedBox(height: 5),
          Text(value, style: AppFonts.textprimary),
        ],
      ),
    );
  }
}

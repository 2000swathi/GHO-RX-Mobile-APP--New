import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/edit_person_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/bloc/profile_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  PersonalInfoModel? personalInfo;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, listState) {
        if (listState is CountryState && personalInfo != null) {
          Navigator.pop(context);

          final countries =
              listState.countryResponse.data.expand((e) => e).toList();

          EditProfileSheetWidget.show(context, personalInfo!, countries);
        } else if (listState is ListFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(listState.error)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: CustomAccountAppBar(
          title: "Personal Information",
          onEdit: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: LoadingAnimation()),
            );
            context.read<ListBloc>().add(FetchCountryList());
          },
        ),
        body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: LoadingAnimation());
            } else if (state is ProfileInfoError) {
              return Center(child: Text(state.message));
            } else if (state is PersonalInfoState) {
              personalInfo = state.personalInfomodel;
              final info = personalInfo!;

              final infoList = [
                {
                  "label": "Full Name",
                  "value": "${info.firstName} ${info.lastName}",
                },
                {"label": "Date of Birth", "value": info.birthDate},
                {"label": "Email", "value": info.email},
                {"label": "Mobile Number", "value": info.phone},
                {"label": "Address 1", "value": info.address1},
                {"label": "Address 2", "value": info.address2},
                {"label": "Country", "value": info.countryName},
                {"label": "State", "value": info.state},
                {"label": "City", "value": info.city},
                {"label": "Zip/Postal Code", "value": info.zipCode},
              ];

              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 47,
                          backgroundColor: AppColors.primarycolor.withAlpha(13),
                          child: ClipOval(
                            child:
                                (info.imageUrl.isNotEmpty)
                                    ? Image.network(
                                      info.imageUrl,
                                      width: 94,
                                      height: 94,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, prog) {
                                        if (prog == null) return child;
                                        return const Center(
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColors.primarycolor,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stack) =>
                                              SvgPicture.asset(
                                                "assets/svg/person.svg",
                                                width: 94,
                                                height: 94,
                                              ),
                                    )
                                    : SvgPicture.asset(
                                      "assets/svg/person.svg",
                                      width: 94,
                                      height: 94,
                                    ),
                          ),
                        ),
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => ProfileDialog(url: info.imageUrl),
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
                  ),
                  const SizedBox(height: 32),
                  ...infoList
                      .map((item) => buildInfo(item['label']!, item['value']!))
                      .toList(),
                  const SizedBox(height: 20),
                ],
              );
            }

            return const Center(child: Text("Invalid State"));
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

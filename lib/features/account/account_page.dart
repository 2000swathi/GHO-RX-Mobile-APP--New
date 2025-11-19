import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_event.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_appdrawer.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/draweritem_tile.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<PicBloc>().add(FetchPicEvent());
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
          scaffoldKey.currentState?.closeDrawer();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const CustomAppDrawer(),
        ),
        drawerEnableOpenDragGesture: false,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profile", style: AppFonts.heading),
          actions: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.settings, color: AppColors.black,size: 35,),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PicBloc, PicState>(
                builder: (context, state) {
                  if (state is PicLoading) {
                    return LoadingAnimation();
                  } else if (state is PicFailure) {
                    return SizedBox();
                  } else if (state is PicSuccess) {
                    final data = state.response["Data"];

                    if (data == null ||
                        data.isEmpty ||
                        data[0] == null ||
                        data[0].isEmpty) {
                      return SizedBox();
                    }

                    final info = data[0][0];

                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 110,
                            width: 110,
                            child: Stack(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 47,
                                    backgroundColor: AppColors.primarycolor
                                        .withAlpha(13),
                                    child:
                                        info["_Url"] != null &&
                                                info["_Url"].isNotEmpty
                                            ? ClipOval(
                                              child: Image.network(
                                                info["_Url"],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                loadingBuilder: (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;

                                                  return Center(
                                                    child: SizedBox(
                                                      height: 15,
                                                      width: 15,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(
                                                              AppColors
                                                                  .primarycolor,
                                                            ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return SvgPicture.asset(
                                                    "assets/svg/person.svg",
                                                    height: 24,
                                                    width: 24,
                                                  );
                                                },
                                              ),
                                            )
                                            : SvgPicture.asset(
                                              "assets/svg/person.svg",
                                              height: 24,
                                              width: 24,
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
                                            (context) => ProfileDialog(
                                              url: info["_Url"],
                                            ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColors.white,
                                      child: SvgPicture.asset(
                                        "assets/svg/account/edit.svg",
                                        height: 16,
                                        width: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        Text(info["FullName"], style: AppFonts.heading),
                        Text(info["email"], style: AppFonts.textSecondary),
                      ],
                    );
                  }
                  return Text("invalid State");
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 49),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/user.png",
                      title: "Personal Information",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.personalinformation,
                        );
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/translation.png",
                      title: "Languages",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.languagescreen);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/accredited 1.png",
                      title: "Accreditations",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.accreditationscreen);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/graduation-hat.png",
                      title: "Education",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.educationscreen);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/refer.png",
                      title: "Professional References",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.professionalreferences);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/agreement.png",
                      title: "Licenses",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.licensescreen);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/health-insurance.png",
                      title: "Professional Indemnity Insurance",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.profesindInsurance);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/folders.png",
                      title: "Documents",
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.documents);
                      },
                    ),
                    DrawerItemTile(
                      imagePath: "assets/svg/account/question-mark.png",
                      title: "Questionnaire",
                    ),
                    const SizedBox(height: 29),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/appdrawer.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/draweritem_tile.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/widget/shapes.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<_DrawerItem> _drawerItems = [
    _DrawerItem(
      title: "Personal Information",
      imagePath: "assets/svg/account/user.png",
      routeName: AppRouter.personalinformation,
    ),
    _DrawerItem(
      title: "Languages",
      imagePath: "assets/svg/account/translation.png",
      routeName: AppRouter.languagescreen,
    ),
    _DrawerItem(
      title: "Accreditations",
      imagePath: "assets/svg/account/accredited 1.png",
      routeName: AppRouter.accreditationscreen,
    ),
    _DrawerItem(
      title: "Specialty",
      imagePath: "assets/svg/account/treatment.png",
      routeName: AppRouter.specialty,
    ),
    _DrawerItem(
      title: "Education",
      imagePath: "assets/svg/account/graduation-hat.png",
      routeName: AppRouter.educationscreen,
    ),
    _DrawerItem(
      title: "Professional References",
      imagePath: "assets/svg/account/refer.png",
      routeName: AppRouter.professionalreferences,
    ),
    _DrawerItem(
      title: "Licenses",
      imagePath: "assets/svg/account/agreement.png",
      routeName: AppRouter.licensescreen,
    ),
    _DrawerItem(
      title: "Professional Indemnity Insurance",
      imagePath: "assets/svg/account/health-insurance.png",
      routeName: AppRouter.profesindInsurance,
    ),
    _DrawerItem(
      title: "Documents",
      imagePath: "assets/svg/account/folders.png",
      routeName: AppRouter.documents,
    ),
    _DrawerItem(
      title: "Questionnaire",
      imagePath: "assets/svg/account/question-mark.png",
      routeName: AppRouter.questionnaire,
    ),
    _DrawerItem(
      title: "Bank Information",
      imagePath: "assets/svg/account/courthouse 1.png",
      routeName: AppRouter.bankInfo,
    ),
  ];

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
          child: AppDrawer(),
        ),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profile", style: AppFonts.heading),
          actions: [
            IconButton(
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
              icon: SvgPicture.asset("assets/svg/account/setting.svg"),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PicBloc, PicState>(
                builder: (context, state) {
                  if (state is PicInitial || state is PicLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          ShimmerShapes.circle(110),
                          const SizedBox(height: 10),
                          ShimmerShapes.line(width: 140, height: 16),
                          const SizedBox(height: 6),
                          ShimmerShapes.line(width: 180, height: 14),
                        ],
                      ),
                    );
                  }

                  if (state is PicSuccess) {
                    return _buildProfile(context, state);
                  }

                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    ..._drawerItems.map(
                      (item) => DrawerItemTile(
                        imagePath: item.imagePath,
                        title: item.title,
                        onTap:
                            item.routeName != null
                                ? () => Navigator.pushNamed(
                                  context,
                                  item.routeName!,
                                )
                                : null,
                      ),
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

  Widget _buildProfile(BuildContext context, PicSuccess state) {
    final data = state.response["Data"];
    if (data == null || data.isEmpty || data[0].isEmpty)
      return Column(
        children: [
          const SizedBox(height: 20),
          Center(child: ShimmerShapes.circle(110)),
          const SizedBox(height: 10),
          ShimmerShapes.line(width: 140, height: 16),
          const SizedBox(height: 6),
          ShimmerShapes.line(width: 180, height: 14),
          const SizedBox(height: 20),
        ],
      );
    final info = data[0][0];
    final imageUrl =
        info["_Url"] != null && info["_Url"].toString().isNotEmpty
            ? "${info["_Url"]}?v=${DateTime.now().millisecondsSinceEpoch}"
            : '';

    final fullName = info["FullName"] ?? '';
    final email = info["email"] ?? '';

    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            height: 110,
            width: 110,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.primarycolor.withAlpha(13),
                  child: ClipOval(
                    child:
                        imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              fadeInDuration: Duration.zero,
                              fadeOutDuration: Duration.zero,
                              placeholder:
                                  (context, url) => SvgPicture.asset(
                                    "assets/svg/person.svg",
                                    width: 110,
                                    height: 110,
                                  ),
                              errorWidget:
                                  (context, url, error) => SvgPicture.asset(
                                    "assets/svg/person.svg",
                                    width: 110,
                                    height: 110,
                                  ),
                            )
                            : SvgPicture.asset(
                              "assets/svg/person.svg",
                              width: 110,
                              height: 110,
                            ),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: InkWell(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (_) => ProfileDialog(url: imageUrl),
                        ),
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
        Text(fullName, style: AppFonts.heading),
        Text(email, style: AppFonts.textSecondary),
      ],
    );
  }
}

class _DrawerItem {
  final String title;
  final String imagePath;
  final String? routeName;

  _DrawerItem({required this.title, required this.imagePath, this.routeName});
}

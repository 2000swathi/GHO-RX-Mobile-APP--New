import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        CustomLogo(
                          mainAxisAlignment: MainAxisAlignment.start,
                          isSmall: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/images/circle arrow.png"),
                          SizedBox(height: 23),
                          Text("Advance Your", style: AppFonts.subheading),
                          Text(
                            "Practice. Securely.",
                            style: AppFonts.subheading,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 15, bottom: 15),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Image.asset("assets/images/round arrow.png"),
                          SizedBox(height: 18),
                          Text(
                            "Clinical Excellence",
                            style: AppFonts.subheading.copyWith(fontSize: 16),
                          ),
                          Text(
                            " Expanded",
                            style: AppFonts.subheading.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primarycolor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22),
                        Image.asset("assets/images/bubbles.png"),
                        SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your account enables you to:",
                              style: AppFonts.labelItalic.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),

                            SizedBox(height: 14),
                            Image.asset("assets/images/3 sq.png"),
                            SizedBox(height: 14),
                            Text(
                              "Accept and Manage cases ",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              "from Global Patients.",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              "Launch secure Tele-",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              "consultations instantly.",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              "Collaborate efficiently with ",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              "International Peers.",
                              style: AppFonts.subtext.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primarycolor),

                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text(
                      "Welcome to the GHO reviewer network!",

                      style: AppFonts.heading.copyWith(
                        fontSize: 32,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Please note: Your profile will be reviewed by our GHO Admin team. Verification usually takes 24–48 hours. Once approved, you’ll be able to access cases, view payments, and start collaborating with patients and hospitals.",
                      style: AppFonts.subtext.copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: CustomButton(
                        text: "Continue",
                        onPressed: () {
                          Navigator.pushNamed(context, "/personalinfo");
                        },
                        iswhite: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

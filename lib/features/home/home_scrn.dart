import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class HomeScrn extends StatelessWidget {
  const HomeScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80.62),
            SizedBox(
              child: CustomLogo(mainAxisAlignment: MainAxisAlignment.start),
            ),
            SizedBox(height: 43.92),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 175,
                  width: 215,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Image.asset("assets/images/circle arrow.png"),
                      SizedBox(height: 23),
                      Text("Advance Your", style: AppFonts.subheading),
                      Text("Practice. Securely.", style: AppFonts.subheading),
                    ],
                  ),
                ),
                Container(
                  height: 344,
                  width: 240,
                  decoration: BoxDecoration(
                    color: AppColors.primarycolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22),
                        Image.asset("assets/images/bubbles.png"),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your account enables ",
                                style: AppFonts.subtext.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                "you to:",
                                style: AppFonts.subtext.copyWith(
                                  color: AppColors.white,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Container(
                height: 132,
                width: 183,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
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
              ),
            ),
            SizedBox(height: 69),
            Expanded(
              child: Container(
                // height: 359,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primarycolor),

                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text(
                      "Welcome to the GHO",
                      style: AppFonts.heading.copyWith(
                        fontSize: 32,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      " reviewer network!",
                      style: AppFonts.heading.copyWith(
                        fontSize: 32,
                        color: AppColors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Please note: Your profile will be reviewed by our GHO Admin ",
                          style: AppFonts.subtext.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "team. Verification usually takes 24–48 hours. Once approved,",
                          style: AppFonts.subtext.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "you’ll be able to access cases, view payments, and start",
                          style: AppFonts.subtext.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "collaborating with patients and hospitals.",
                          style: AppFonts.subtext.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 65),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: CustomButton(
                            text: "Continue",
                            onPressed: () {},
                            iswhite: true,
                          ),
                        ),
                        // SizedBox(height: 69),
                      ],
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

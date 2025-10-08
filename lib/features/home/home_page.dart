import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/reusable_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CaseAppBar(title: "HELLO"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffFFF8E6),
                border: Border.all(color: Color(0xffF6E3B3), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 16.67,
                    height: 16.67,
                    decoration: BoxDecoration(
                      color: Color(0xffFFF8E6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xff983C3C), width: 1.5),
                    ),
                    child: Icon(
                      Icons.priority_high,
                      color: Color(0xff983C3C),
                      size: 10,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Verification Pending",
                          style: AppFonts.textblue.copyWith(
                            fontFamily: 'Roboto',
                            color: Color(0xff983C3C),
                          ),
                        ),

                        Text(
                          textAlign: TextAlign.justify,
                          style: AppFonts.textappbar.copyWith(
                            fontFamily: 'Roboto Flex',
                            color: Color(0xffAA5757),
                          ),
                          "Your profile is currently under review by a GHO administrator.We will notify you when it is approved.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Key Performance Indicators",
              style: AppFonts.subtext.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CommonContainer(
                    borderColor: Color(0xff667EFA).withAlpha(33),
                    color: Color(0xff667EFA).withAlpha(5),
                    textColor: Color(0xff384EC1),

                    data: "Second Opinion",
                    data1: "17",

                    data2: "vs last period",
                  ),
                ),
                SizedBox(width: 12),

                Expanded(
                  child: CommonContainer(
                    borderColor: Color(0xffFF8A65).withAlpha(48),
                    color: Color(0xffFF8A65).withAlpha(10),
                    textColor: Color(0xffB93106),
                    data: "Total Consults",
                    data1: "3",
                    data2: "vs last period",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CommonContainer(
                    borderColor: Color(0xffC5EFC8),
                    color: Color(0xffF1FFF2),
                    textColor: Color(0xff146B1A),
                    data: "Total Revenue",
                    data1: "\$150.31",
                    data2: "vs last period",
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CommonContainer(
                    borderColor: Color(0xffCCCDCD),
                    color: Color(0xffF4F5F7),
                    textColor: Color(0xff404040).withAlpha(48),
                    data: "Next Payout",
                    data1: "\$80.00",
                    data2: "Due: Oct 10",
                  ),
                ),
              ],
            ),
            // SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Second Opinion Request",
                  style: AppFonts.subheading.copyWith(fontSize: 16),
                ),

                Text(
                  "See All",
                  style: AppFonts.subheading.copyWith(fontSize: 16),
                ),
              ],
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Container(
                // height: 222,
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8FF),
                  boxShadow: [BoxShadow(color: Color(0xff667EFA).withAlpha(5))],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Color(0xff667EFA).withAlpha(80),
                  ),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Case Identifier", style: AppFonts.subtext),
                        Text("Allotted Time: 5hrs", style: AppFonts.subtext),
                      ],
                    ),
                    SizedBox(width: 83),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GHO-2024-9481", style: AppFonts.subtext),
                        Text("Due Date: Oct 9, 2024", style: AppFonts.subtext),
                      ],
                    ),
                    Text(
                      "34-year-old female presenting with acute chest pain, radiating to left arm. Requesting urgent cardiologist \nopinion. ",
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(2)),
                        Expanded(
                          child: ReusableBtn(
                            btnName: "Accept Case",
                            onTap: () {},
                            bgColor: Color(0xff667EFA),
                            textColor: Color(0xffFFFFFF),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ReusableBtn(
                            btnName: "Deny",
                            onTap: () {},
                            bgColor: Color(0xff667EFA).withAlpha(15),
                            textColor: Color(0xff667EFA),
                          ),
                        ),
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

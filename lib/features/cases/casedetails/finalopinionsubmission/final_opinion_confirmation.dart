import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_checkbox_declaration.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_qa.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_container.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/confirm_submission_dialog.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/widget/doc_container.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class FinalOpinionConfirmation extends StatelessWidget {
  const FinalOpinionConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Row(
          children: [
            Text("Case ID: GHO-2024-9481", style: AppFonts.heading),
            Spacer(),
            SvgPicture.asset("assets/svg/roundedMsg.svg"),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text("Aswathy K Pradeep", style: AppFonts.subheading),
                  Spacer(),
                  Container(
                    width: 68.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: AppColors.successcolor.withAlpha(10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "In Review",
                        style: AppFonts.subtext.copyWith(
                          fontSize: 10,
                          color: AppColors.successcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  Text("Female", style: AppFonts.subtext),
                  SizedBox(width: 14.w),
                  SvgPicture.asset("assets/svg/calender.svg"),
                  Text("12 Dec 1987 (38 years)", style: AppFonts.subtext),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "3 hours left",
                    style: AppFonts.textSecondary.copyWith(
                      fontSize: 16,
                      color: AppColors.red,
                    ),
                  ),

                  SizedBox(width: 4),
                  Icon(Icons.circle, size: 6, color: AppColors.red),
                  SizedBox(width: 4),
                  Text(
                    "Due Date: Oct 14, 2025",
                    style: AppFonts.textSecondary.copyWith(
                      fontSize: 16,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.profilepink.withAlpha(13),
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
                        border: Border.all(
                          color: Color(0xff983C3C),
                          width: 1.5,
                        ),
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
                            "Review Carefully",
                            style: AppFonts.textblue.copyWith(
                              color: Color(0xff983C3C),
                            ),
                          ),

                          Text(
                            textAlign: TextAlign.left,
                            style: AppFonts.textappbar.copyWith(
                              fontFamily: 'Roboto Flex',
                              color: Color(0xffAA5757),
                            ),
                            "This the patient-facing final document. Once submitted, it cannot be edited.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomContainer(
                greyHeading: "Written Report",
                icon: Icon(Icons.more_horiz_sharp),
                subHeading: "Summary of Findings:",
                datas:
                    "The MRI scan shows mild cervical spondylosis with no significant spinal cord compression. The neurological exam is largely normal except for mild..",
                hintText: "Read more...",
              ),
              SizedBox(height: 16),

              CustomContainer(
                greyHeading: "Attached Documents",
                customWidgets: Container(
                  width: 41.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: AppColors.successcolor.withAlpha(10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "2 Files",
                      style: AppFonts.subtext.copyWith(
                        fontSize: 10,
                        color: AppColors.successcolor,
                      ),
                    ),
                  ),
                ),

                icon: Icon(Icons.more_horiz_sharp),

                customWidgets1: [
                  SizedBox(height: 16.h),
                  DocContainer(
                    iconDoc: SvgPicture.asset("assets/svg/pdfIcons.svg"),
                    fileName: "Report name_T1.pdf",
                  ),
                  SizedBox(height: 4.h),
                  DocContainer(
                    iconDoc: SvgPicture.asset("assets/svg/pdfIcons.svg"),
                    fileName: "Report name_Agt_1234.pdf",
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              CustomContainer(
                greyHeading: "Audio Summary",

                icon: Icon(Icons.more_horiz_sharp),

                customWidgets1: [
                  SizedBox(height: 16.h),

                  DocContainer(
                    iconDoc: SvgPicture.asset("assets/svg/audioIcons.svg"),
                    fileName: "Audio26378",
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              CustomContainer(
                greyHeading: "Q&A",
                icon: Icon(Icons.more_horiz_sharp),
                customWidgets1: [
                  CommonQa(
                    bullet: SvgPicture.asset(
                      "assets/svg/blueBullet.svg",
                      width: 13.33,
                      height: 13.333,
                    ),
                    qamsg1:
                        "Do my symptoms definitely suggest \na stroke, or could it be something else?",
                    ans:
                        "Ans: Lorem ipsum dolor sit amet consectetur. Laoreet proin risus ultricies volutpat eget sagittis. Nibh id amet sit nibh et purus.",
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.link, color: AppColors.textSecondary),
                      SizedBox(width: 6.5),
                      Text(
                        "https://app.yourcompany.com/feature/123",
                        style: AppFonts.textappbar.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  CommonQa(
                    bullet: SvgPicture.asset("assets/svg/blueBullet.svg"),
                    qamsg1:
                        "What risks do I face if I delay admission or treatment?",
                    ans:
                        "Ans: Lorem ipsum dolor sit amet consectetur. Laoreet proin risus ultricies volutpat eget sagittis. Nibh id amet sit nibh et purus.",
                  ),
                ],
                hintText: "View 2 more Q&A",
              ),
              SizedBox(height: 16.h),
              CustomContainer(
                greyHeading: "Clinical and Compliance Declaration",
                icon: Icon(Icons.more_horiz_sharp),
                commonCheckbox: [
                  CommonCheckboxDeclaration(
                    declarationText:
                        "I have reviewed all submitted patient information, including images, lab reports, and clinical history, and confirm the completeness of my review.",
                  ),
                  SizedBox(height: 16.h),
                  CommonCheckboxDeclaration(
                    declarationText:
                        "I attest that this second opinion is based solely on the provided documentation and reflects my independent, professional clinical judgment.",
                  ),
                  SizedBox(height: 16.h),
                  CommonCheckboxDeclaration(
                    declarationText:
                        "I confirm that I hold the necessary active license and specialized expertise required to provide this second opinion.",
                  ),
                  SizedBox(height: 16.h),
                  CommonCheckboxDeclaration(
                    declarationText:
                        "I have adhered to all platform guidelines, confidentiality standards, and relevant professional codes of conduct in generating this report.",
                  ),
                ],
              ),

              SizedBox(height: 36),
              CustomButton(
                text: "Confirm & Submit Final Review",
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withAlpha(70), // dim background
                    builder: (context) => const ConfirmSubmissionDialog(),
                  );
                },
              ),
              SizedBox(height: 53),
            ],
          ),
        ),
      ),
    );
  }
}

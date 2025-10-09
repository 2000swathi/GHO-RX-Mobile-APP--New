import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Recordaudio extends StatelessWidget {
  const Recordaudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: DottedBorder(
            color: AppColors.hint1color,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius:  Radius.circular(8.0),
            dashPattern: [7, 8],
            child: Container(
              width: double.infinity,
              padding:  EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/Document.svg"),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      Text(
                        'Drag and drop your files',
                        style: AppFonts.subheading,
                      ),
                       SizedBox(height: 5.0),
                      Text(
                        'JPEG, PND, PDF, and MP4 formats, up to 1GB',
                        style: AppFonts.hinttext,
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: 100,
                        child: CustomButton(text: "Select", onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding:  EdgeInsets.all(8.0),
          child: DottedBorder(
            color: AppColors.hint1color,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: const Radius.circular(8.0),
            dashPattern: [7, 8],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/record.svg"),
             SizedBox(height: 8.0),
                Column(
                  children: [
                    Text('Record Audio Summary', style: AppFonts.subheading),
                   SizedBox(height: 5.0),
                    Text(
                      'Provide a short audio summary for clarity.',
                      style: AppFonts.hinttext,
                    ),
                  SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            text: "Start Recording",
                            onPressed: () {},
                            color: AppColors.warningred,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("00:00", style: AppFonts.subheading),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Uploaded files ", style: AppFonts.subheading16),
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            padding:  EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.hint1color),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/pdf Icons.svg"),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report name_T1.pdf",
                        style: AppFonts.subheading16.copyWith(fontSize: 16),
                      ),
                    SizedBox(height: 5),
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("23.5MB | 55%", style: AppFonts.hinttext2),
                           Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.hint2color,
                          ),
                          Text("37 sec left", style: AppFonts.hinttext2),
                          Row(
                            children: [
                               Icon(
                                Icons.hourglass_empty,
                                size: 16,
                                color: AppColors.hint2color,
                              ),
                              SizedBox(width: 2),
                              Text("Uploading", style: AppFonts.hinttext2),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset("assets/svg/trash.svg"),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding:  EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            padding:  EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.hint1color),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/pdf Icons.svg"),
              SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report name_Agt_1234.pdf",
                        style: AppFonts.subheading16.copyWith(fontSize: 16),
                      ),
                     SizedBox(height: 5),
                      Wrap(
                        spacing: 4.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("23.5MB | 100%", style: AppFonts.hinttext2),
                        Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.hint2color,
                          ),
                          Text(
                            "Upload Successfully",
                            style: AppFonts.hinttext2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset("assets/svg/trash.svg"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

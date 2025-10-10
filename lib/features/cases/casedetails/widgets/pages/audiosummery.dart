import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Audiosummery extends StatelessWidget {
  const Audiosummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      padding:  EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset:  Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audio Summery",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primarycolor),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              children: <Widget>[
                SvgPicture.asset('assets/svg/audio.svg'),
               SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audio0019681.mp3",
                        style: AppFonts.subheading16.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.07,
                          backgroundColor: AppColors.hint2color.withAlpha(90),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primarycolor,
                          ),
                          minHeight: 5,
                        ),
                      ),
                       SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("00:21", style: AppFonts.textappbar),
                          Text("05:24", style: AppFonts.textappbar),
                        ],
                      ),

                      SizedBox(height: 6),
                    ],
                  ),
                ),
                // const SizedBox(width: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("00:21", style: AppFonts.textappbar),
                //     Text("/", style: AppFonts.textappbar),
                //     Text("05:24", style: AppFonts.textappbar),
                //   ],
                // ),
               SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/play.svg',
                        width: 20,
                        height: 20,
                      ),
                    SizedBox(width: 4),
                      Text(
                        'Play',
                        style: AppFonts.textwhite.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Summerypage extends StatelessWidget {
  const Summerypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary of Medical Records',
            style: AppFonts.subheading16,
          ),
          const SizedBox(height: 10),
          _buildAudioSummaryRow(),
          const SizedBox(height: 10),
          Text(
            "I am a 60-year-old male experiencing slurred speech and weakness in my right arm for the past 2 hours. I consulted a doctor who mentioned it could be a possible stroke and advised immediate admission for further tests and treatment. As I am not fully convinced with the explanation and plan provided, I am seeking an urgent second opinion from a neurologist. I have attached the reports and necessary documents available with me for your review.",
            style: AppFonts.textprimary,
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
Widget _buildAudioSummaryRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color:AppColors.primarycolor.withAlpha( 30),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset('assets/svg/audio.svg', width: 24, height: 24),
            const SizedBox(width: 10),
            Text('Audio Summary', style: AppFonts.buttontxt16),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primarycolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            minimumSize: Size.zero,
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/svg/play.svg', width: 20, height: 20),
              SizedBox(width: 4),
              Text('Play', style: TextStyle(color:AppColors.white, fontSize: 14)),
            ],
          ),
        ),
      ],
    ),
  );
}

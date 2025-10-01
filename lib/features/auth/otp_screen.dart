import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondarycolor,
            width: 2,
          ),
        ),
      ),
    );

    return Scaffold(
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 24),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,  
        mainAxisAlignment: MainAxisAlignment.center,      
          children: [
            SizedBox(height: 30),
            CustomLogo(),
            SizedBox(height: 40),
            Text("OTP Verification", style: AppFonts.heading),
            SizedBox(height: 15),
            Text(
                "OTP has been sent on your registered mobile number and email.",
                style: AppFonts.subtext,
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 40),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              cursor: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 24,
                  width: 2,
                  color: AppColors.secondarycolor,
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.secondarycolor,
                      width: 2,
                    ),
                  )
                ),
                ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Didn’t receive code?", style: AppFonts.hinttext),
                Spacer(),
                Text("Resend in 00:59", style: AppFonts.textblue),
              ],
            ),
            SizedBox(height: 40),
            CustomButton(
              text: "Verify",
             onPressed: () {}
            ),
          ],       
        ),
     ),
    );
  }
}
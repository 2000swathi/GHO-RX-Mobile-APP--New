import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_snackbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_event.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_state.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/utilities/timer/otp_timer.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class ForgotOtpScreen extends StatefulWidget {
  OtpResponse otpResponse;
  ForgotOtpScreen({super.key, required this.otpResponse});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  late TextEditingController otpController;
  late OTPTimer otpTimer;
  int remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    otpTimer = OTPTimer();
    _startOTPTimer();
  }

  void _startOTPTimer() {
    otpTimer.start(
      seconds: 60,
      onTick: (seconds) {
        setState(() {
          remainingSeconds = seconds;
        });
      },
      onFinish: () {
        setState(() {
          remainingSeconds = 0;
        });
      },
    );
  }

  void _restartTimer() {
    otpTimer.stop();
    setState(() {
      remainingSeconds = 60;
    });
    _startOTPTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    otpTimer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.secondarycolor, width: 2),
        ),
      ),
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotOtpSuccess) {
          final msg =
              state.otpResponse.info.isNotEmpty
                  ? state.otpResponse.info
                  : "OTP verified";

          CustomSnackbar.show(context, msg, true);

          Navigator.pushNamed(context, '/forgot_password');
        } else if (state is ResendOTPSuccess) {
         final msg = state.otpResponse.info;


          CustomSnackbar.show(context, msg, true);

          setState(() {
            widget.otpResponse = state.otpResponse;
            _restartTimer();
          });
        } else if (state is AuthFailure) {
          CustomSnackbar.show(context, state.error, false);
        }
      },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomLogo(),
                        const SizedBox(height: 40),
                        Text("OTP Verification", style: AppFonts.heading),
                        const SizedBox(height: 15),
                        Text(
                          widget.otpResponse.info,
                          style: AppFonts.subtext,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Pinput(
                          length: 6,
                          controller: otpController,
                          defaultPinTheme: defaultPinTheme,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Didn’t receive code?",
                              style: AppFonts.hinttext,
                            ),
                            const Spacer(),
                            remainingSeconds > 0
                                ? Text(
                                  "Resend in 00:${remainingSeconds.toString().padLeft(2, '0')}",
                                  style: AppFonts.textblue,
                                )
                                : InkWell(
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      OTPResend(
                                        email:
                                            widget.otpResponse.data[0][0].email,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: AppFonts.textblue.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primarycolor,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return LoadingAnimation();
                            }
                            return CustomButton(
                              text: "Verify",
                              onPressed: () {
                                final otp = otpController.text.trim();
                                if (otp.isEmpty) {
                                  CustomSnackbar.show(
                                    context,
                                    "Please enter the OTP",
                                    false,
                                  );
                                  return;
                                }
                                context.read<AuthBloc>().add(
                                  ForgotOtp(
                                    email: widget.otpResponse.data[0][0].email,
                                    otp: otp,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

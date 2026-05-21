import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_snackbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_country_drop_down_widget.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_bloc.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_event.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_state.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/update_ui.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Country? selectedCountry;

  @override
  void initState() {
    super.initState();

    /// ✅ SAFE CALL AFTER BUILD
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<UpdateBloc>().add(CheckForUpdateEvent());
      context.read<ListBloc>().add(FetchCountryList());
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// ================= AUTH =================
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              phoneController.clear();

              setState(() {
                selectedCountry = null;
              });

              Navigator.pushNamed(
                context,
                '/otp',
                arguments: state.otpResponse,
              );
            }

            if (state is AuthFailure) {
              CustomSnackbar.show(context, state.error, false);
            }
          },
        ),

        /// ================= UPDATE =================
        BlocListener<UpdateBloc, UpdateState>(
          listener: (context, state) {
            if (state is UpdateAvailable) {
              UpdateUIHelper.showUpdateBottomSheet(context);
            }

            if (state is UpdateError) {
              debugPrint("Update error: ${state.message}");
            }
          },
        ),
      ],

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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),

                          CustomLogo(),
                          const SizedBox(height: 30),

                          Text("Welcome to GHORx", style: AppFonts.heading),

                          const SizedBox(height: 18),

                          Text(
                            "Log in to streamline global case acceptance and secure teleconsultations.",
                            style: AppFonts.subtext,
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 25),

                          /// ================= COUNTRY =================
                          BlocBuilder<ListBloc, ListState>(
                            builder: (context, state) {
                              if (state is ListLoading) {
                                return const LoadingAnimation();
                              }

                              if (state is CountryState) {
                                final countries = state.countryResponse.data
                                    .expand((e) => e)
                                    .toList();

                                return CustomCountryDropdown<Country>(
                                  name: "Country",
                                  hintText: "Select Country",
                                  items: countries,
                                  value: selectedCountry,
                                  labelBuilder:
                                      (country) => country.countryName,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                      phoneController.clear();
                                    });
                                  },
                                );
                              }

                              return const SizedBox();
                            },
                          ),

                          const SizedBox(height: 20),

                          /// ================= PHONE =================
                          CustomTextFormField(
                            name: "Phone #",
                            hintText: "Enter phone number",
                            controller: phoneController,
                            keyboardType: TextInputType.phone,

                            validator: (value) {
                              final country = selectedCountry;

                              if (value == null || value.isEmpty) {
                                return "Please enter phone number";
                              }

                              if (country == null) {
                                return "Select country first";
                              }

                              final min = country.minLength ?? 0;
                              final max = country.maxLength ?? 12;
                              final len = value.trim().length;

                              if (len < min) {
                                return "Minimum $min digits required";
                              }

                              if (len > max) {
                                return "Maximum $max digits allowed";
                              }

                              return null;
                            },

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                selectedCountry?.maxLength ?? 12,
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          /// ================= BUTTON =================
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const LoadingAnimation();
                              }

                              return CustomButton(
                                text: "Sign In",
                                onPressed: () {
                                  final country = selectedCountry;
                                  final phone = phoneController.text.trim();

                                  if (!(_formKey.currentState?.validate() ??
                                      false)) {
                                    return;
                                  }

                                  if (country == null) {
                                    CustomSnackbar.show(
                                      context,
                                      "Please select country",
                                      false,
                                    );
                                    return;
                                  }

                                  final min = country.minLength ?? 0;
                                  final max = country.maxLength ?? 12;

                                  if (phone.length < min) {
                                    CustomSnackbar.show(
                                      context,
                                      "Minimum $min digits required",
                                      false,
                                    );
                                    return;
                                  }

                                  if (phone.length > max) {
                                    CustomSnackbar.show(
                                      context,
                                      "Maximum $max digits allowed",
                                      false,
                                    );
                                    return;
                                  }

                                  context.read<AuthBloc>().add(
                                        LoginRequested(
                                          countryCode:
                                              country.countryID.toString(),
                                          phone: phone,
                                        ),
                                      );
                                },
                              );
                            },
                          ),

                          const Spacer(),

                          Text(
                            "Not a reviewer yet? Join GHORx Network.",
                            textAlign: TextAlign.center,
                            style: AppFonts.hinttext2,
                          ),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/addPage');
                            },
                            child: Text(
                              "Join Reviewer Network",
                              style: AppFonts.textprimary,
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
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
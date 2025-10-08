import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_state.dart';

import 'bloc/profile_bloc.dart';
import 'repository/Profile_repo.dart';

class DrLicense extends StatelessWidget {
  const DrLicense({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProfileRepository();

    return BlocProvider(
      create: (_) => ProfileBloc(repository: repository)..add(FetchLicence()),
      child: Scaffold(
        appBar: CaseAppBar(title: "License"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: LoadingAnimation());
              } else if (state is LicenseState) {
                final licenseList = state.licenseModel.data;

                if (licenseList.isEmpty) {
                  return const Center(child: Text("No license added"));
                }

                return ListView.builder(
                  itemCount: licenseList.length,
                  itemBuilder: (context, index) {
                    final license = licenseList[index];
                    return Card(
                      color: AppColors.primarycolor,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRow("License Number", license.licenseNumber),
                            _buildRow(
                              "Issuing Authority",
                              license.issuingAuthority,
                            ),
                            _buildRow("License Type", license.licenseType),
                            _buildRow("Issue Date", license.issueDate),
                            _buildRow("Expiry Date", license.expiryDate),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ProfileError) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    final displayValue =
        (value.isEmpty || value == null || value.isEmpty) ? "-" : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: AppFonts.subtext.copyWith(color: AppColors.white),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              displayValue,
              style: AppFonts.subtext.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_state.dart';

import 'repository/Profile_repo.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProfileRepository();

    return BlocProvider(
      create:
          (_) =>
              ProfileBloc(repository: repository)..add(FetchPersonalInfo()),
      child: Scaffold(
        appBar: CaseAppBar(title: "Personal Info"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: LoadingAnimation());
              } else if (state is PersonalInfoState) {
                final info = state.personalInfomodel;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    _buildRow(
                      "Full Name",
                      "${info.firstName} ${info.lastName}",
                    ),
                    _buildRow("Last Name", info.lastName),
                    _buildRow("Email", info.email),
                    _buildRow("Phone", info.phone),
                    _buildRow("Country", info.countryName),
                    _buildRow("Address 1", info.address1),
                    _buildRow("Address 2", info.address2),
                    _buildRow("City", info.city),
                    _buildRow("State", info.state),
                    _buildRow("Zip Code", info.zipCode),
                    _buildRow("Birth Date", info.birthDate),
                  ],
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
    final displayValue = (value.isEmpty || value == "") ? "-" : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$label:", style: AppFonts.subtext)),
          Expanded(
            flex: 5,
            child: Text(
              displayValue,
              style: AppFonts.subtext.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

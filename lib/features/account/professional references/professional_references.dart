import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/professionalreff_card.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/bloc/professionalref_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';
import 'package:ghorx_mobile_app_new/features/account/professional references/widget/addEditBottomSheet.dart';

class ProfessionalReferencesScreen extends StatefulWidget {
  ProfessionalReferencesScreen({super.key});

  @override
  State<ProfessionalReferencesScreen> createState() =>
      _ProfessionalReferencesScreenState();
}

class _ProfessionalReferencesScreenState
    extends State<ProfessionalReferencesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessionalrefBloc>().add(FetchProfessionalref());
  }

  @override
  Widget build(BuildContext context) {
    // final professionalrefBloc = context.read<ProfessionalrefBloc>();
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Professional References",
        onAdd: () {
          AddProfessionalRefBottomSheet.showSheet(
            context,
            null, // info = null for Add
            profRefBloc: context.read<ProfessionalrefBloc>(),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<ProfessionalrefBloc, ProfessionalrefState>(
          builder: (context, state) {
            if (state is ProfessionalrefLoading) {
              return const Center(child: LoadingAnimation());
            }

            if (state is ProfessionalrefError) {
              return Center(child: Text(state.message));
            }
            if (state is ProfessionalrefgetState) {
              final info = state.professionalerefModel.data;
              if (info.isEmpty) {
                return Center(child: Text("No Professional reference Added"));
              }
              return ListView.builder(
                itemCount: info.length,
                itemBuilder: (context, index) {
                  final reference = info[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: ProfessionalRefeCard(
                      index: index + 1,
                      fullnameRefe: reference.fullName,
                      designationRefe: reference.designation,
                      // designation1Refe: reference.designation1,
                      relationshipRefe: reference.relationship,
                      phoneRefe: reference.phone,
                      onEdit: () {},
                      onDelete: () {},
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

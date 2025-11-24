import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_dialog.dart';

class Delacc extends StatelessWidget {
  const Delacc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
        if (state is DeleteLoading) {
          return const Center(child: LoadingAnimation());
        } else if (state is DeleteSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.login,
              (route) => false,
            );
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          });
        } else if (state is DeleteFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showErrorMessage(context, state.error);
          });
        }
        return customDialog(
          svgPath: "assets/svg/account/del.svg",
          heading: "Delete Account",
          warningText:
              "Are you sure you want to delete your account? \nThis action cannot be undone.",
          colors: AppColors.red.withAlpha(15),
          imgColor: AppColors.red,
          btnTxt1: "cancel",
          btnbg1: AppColors.cards1,
          btnTextClr: AppColors.textPrimary,
          btnTxt2: "Delete Account",
          btnbg2: AppColors.red,
          btn2pressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/widget/bankInfocard.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class Bankinfoscrn extends StatefulWidget {
  Bankinfoscrn({super.key});

  @override
  State<Bankinfoscrn> createState() => _BankinfoscrnState();
}

class _BankinfoscrnState extends State<Bankinfoscrn> {
  @override
  void initState() {
    super.initState();
    context.read<BankInfoBloc>().add(FetchBankInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(title: "Bank Information"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(onAdd: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<BankInfoBloc, BankInfoState>(
          builder: (context, state) {
            if (state is BankInfoLoading) {
              return Center(child: LoadingAnimation());
            } else if (state is BankInfoError) {
              return Center(child: Text(state.message));
            } else if (state is BankInfoGetState) {
              final info = state.bankListModel.data;
              if (info.isEmpty) {
                return Center(child: Text("No Bank Informations"));
              }
              return ListView.builder(
                itemCount: info.length,
                itemBuilder: (context, index) {
                  final bankinfo = info[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Bankinfocard(
                      index: index,
                      bankName: bankinfo.bankName,
                      accounName: bankinfo.accountHolderName,
                      accountType: bankinfo.accountType,
                      accountNumber: bankinfo.accountNumber,
                    ),
                  );
                },
              );
            }
            return Center(child: Text("Invalid State"));
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/bloc/payment_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/widgets/common_days_dropdown.dart';

class PayReceived extends StatelessWidget {
  const PayReceived({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const SizedBox(height: 20),
          KPIHeader2(),
          const SizedBox(height: 25),

          Expanded(
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return Center(child: LoadingAnimation());
                }

                if (state is PaymentSuccess) {
                  final list = state.response["Data"][0];

                  if (list.isEmpty) {
                    return Center(
                      child: Text("(No transactions in this time period)"),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final pay = list[index];
                      return ListTile(
                        title: Text("${pay["Name"]}"),
                        subtitle: Text("Case ID : ${pay["CaseID"]}"),
                        leading: Icon(
                          Icons.verified,
                          color: AppColors.successcolor,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${pay["AmountPaid"]}",
                              style: AppFonts.subtext.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text("${pay["PaymentDate"]}"),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text("No data"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

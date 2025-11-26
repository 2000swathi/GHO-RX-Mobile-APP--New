import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/bloc/payment_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/widgets/common_days_dropdown.dart';

class PayReceived extends StatelessWidget {
  PayReceived({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 20),

              // DailyPaymentGraph(),

              // SizedBox(height: 24),
              KPIHeader2(),

              SizedBox(height: 25),

              BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentLoading) {
                    return LoadingAnimation();
                  }

                  if (state is PaymentSuccess) {
                    final list = state.response["Data"][0];
                    if (list.isEmpty) {
                      return Column(
                        children: [
                          Text("(No transactions in this time period)"),
                          SizedBox(height: 20,)
                        ],
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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

                  return Text("No data");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

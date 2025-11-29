import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/bloc/payment_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';

class PayPending extends StatelessWidget {
  const PayPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Pending Payments",
            style: AppFonts.subtext.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 12),

          Expanded(
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return Center(child: LoadingAnimation());
                }

                if (state is PaymentSuccess) {
                  final List pendingList = state.response["Data"][1] ?? [];

                  if (pendingList.isEmpty) {
                    return Center(
                      child: Text("No pending payments"),
                    );
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: pendingList.length,
                    itemBuilder: (context, index) {
                      final pay = pendingList[index];

                      return Card(
                        elevation: 0,
                        color: AppColors.white,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(Icons.error, color: AppColors.warningred),

                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pay["Name"]),
                              Text(
                                pay["AmountDue"].toString(),
                                style: AppFonts.subheading16,
                              ),
                            ],
                          ),

                          subtitle: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Case ID: ${pay["CaseID"]}",
                                style: AppFonts.subtext,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return SizedBox();
              },
            ),
          ),

          Divider(color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

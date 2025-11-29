import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/bloc/earnings_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/bloc/payment_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/pay_pending.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/pay_received.dart';
import 'package:ghorx_mobile_app_new/features/payment/widgets/shimmer.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    context.read<EarningsBloc>().add(FetchEarningsInfo(dateValue: "7"));
    context.read<PaymentBloc>().add(FetchPaymentInfo(dateValue: "7"));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CaseAppBar(
          height: 120.h,
          isappbarHeight: 75.h,
          title: "Earnings",
          subTitle: "Reviewer Earnings Dashboard",
          tabBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: BlocBuilder<EarningsBloc, EarningsState>(
              builder: (context, state) {
                if (state is EarningsLoading) {
                  return PaymentShimmer();
                } else if (state is EarningsFailure) {
                  return Text(state.message);
                } else if (state is EarningsSuccess) {
                  final pay = state.response["Data"];
                  return TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.primarycolor,
                    indicatorWeight: 3,
                    tabs: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primarycolor.withAlpha(37),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Tab(text: "Received Payment"),
                              Row(
                                children: [
                                  // const Icon(Icons.currency_rupee),
                                  Text(
                                    pay[0][0]["RecievedPayment"].toString(),
                                    style: AppFonts.heading.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primarycolor.withAlpha(37),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Tab(text: "Pending Payment"),
                              Row(
                                children: [
                                  // const Icon(Icons.currency_rupee),
                                  Text(
                                    pay[0][0]["PendingPayment"].toString(),
                                    style: AppFonts.heading.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),

        body: TabBarView(
          children: [
            RefreshIndicator(
              color: AppColors.white,
              backgroundColor: AppColors.primarycolor,
              onRefresh: () async {
                context.read<PaymentBloc>().add(
                  FetchPaymentInfo(dateValue: "7"),
                );
              },
              child: PayReceived(),
            ),
            RefreshIndicator(
              color: AppColors.white,
              backgroundColor: AppColors.primarycolor,
              onRefresh: () async {
                context.read<PaymentBloc>().add(
                  FetchPaymentInfo(dateValue: "7"),
                );
              },
              child: PayPending(),
            ),
          ],
        ),
      ),
    );
  }
}

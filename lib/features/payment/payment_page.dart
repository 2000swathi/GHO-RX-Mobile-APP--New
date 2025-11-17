import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/pay_pending.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/pay_received.dart';
import 'package:ghorx_mobile_app_new/features/payment/widgets/payment_appbar.dart';

class PaymentPage extends StatelessWidget {
  final double height;
  const PaymentPage({super.key, this.height = 70});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CaseAppBar(
          height: 120,
          title: "Earnings",
          subTitle: "Reviewer Earnings Dashboard",
          tabBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primarycolor,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primarycolor.withAlpha(
                      37,
                    ), // outline color
                    width: 1, // border thickness
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tab(text: "Received Payment"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.currency_rupee, color: AppColors.black),
                          Text(
                            "13,200",
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
                    color: AppColors.primarycolor.withAlpha(
                      37,
                    ), // outline color
                    width: 2, // border thickness
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tab(text: "Pending Payment"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.currency_rupee, color: AppColors.black),
                          Text(
                            "2400",
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
          ),
        ),
        body: const TabBarView(children: [PayReceived(), PayPending()]),
      ),
    );
  }
}

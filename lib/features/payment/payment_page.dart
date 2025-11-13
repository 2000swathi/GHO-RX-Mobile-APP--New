import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
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
        appBar: PaymentAppbar(
          height: 140,
          tabBar: TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primarycolor,
            indicatorWeight: 4,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: [
              Tab(text: "Received Payment"),
              Tab(text: "Pending Payments"),
            ],
          ),
        ),
        body: const TabBarView(children: [PayReceived(), PayPending()]),
      ),
    );
  }
}

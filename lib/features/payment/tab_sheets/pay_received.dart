import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/payment/widgets/common_days_dropdown.dart';

class PayReceived extends StatelessWidget {
  const PayReceived({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                height: 382,
                width: double.infinity,
                child: Container(
                  child: Image.asset(
                    "assets/images/statics.png",
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 24),
              KPIHeader2(),
              SizedBox(height: 25),
              ListView.builder(
                shrinkWrap:
                    true, // Important! Makes list take only needed space
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,

                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: AppColors.white,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.verified, color: AppColors.green),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Helen M Martin"), Text("₹1,200.00")],
                      ),

                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Case ID: GHO-2024-9610"),
                          Text("23/08/2025 11:16 am"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

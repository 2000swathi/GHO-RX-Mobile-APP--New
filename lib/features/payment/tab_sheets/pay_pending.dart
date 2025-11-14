import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PayPending extends StatelessWidget {
  const PayPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.white,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.error, color: AppColors.warningred),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Mariyan Thomas"), Text("₹1,200.00")],
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
            ),
            Divider(color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

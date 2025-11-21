import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class Bankinfocard extends StatelessWidget {
  final int index;
  final String bankName;
  final String accounName;
  final String accountType;
  final String accountNumber;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const Bankinfocard({
    super.key,
    required this.index,
    required this.bankName,
    required this.accounName,
    required this.accountType,
    required this.accountNumber,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Bank Information $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        {"label": "Bank Name:", "value": bankName},
        {"label": "Account Name:", "value": accounName},
        {"label": "Account Type:", "value": accountType},
        {"label": "Account Number:", "value": accountNumber},
      ],
    );
  }
}

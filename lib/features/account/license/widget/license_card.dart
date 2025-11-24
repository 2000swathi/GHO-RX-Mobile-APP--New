import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class LicenseCard extends StatelessWidget {
  final int index;
  final String licenseNumber;
  final String licenseType;
  final String issueDate;
  final String expiryDate;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LicenseCard({
    super.key,
    required this.index,
    required this.licenseNumber,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
    this.onEdit,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "License $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "License Number:", "value": licenseNumber },
        { "label": "License Type:", "value": licenseType },
        { "label": "Issue Date:", "value": issueDate },
        { "label": "Expiry Date:", "value": expiryDate },
      ],

    );
  }
}
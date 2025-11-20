import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class InsuranceCard extends StatelessWidget {
  final int index;
  final String providerId;
  final String providerName;
  final String issueDate;
  final String expiryDate;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const InsuranceCard({
    super.key,
    required this.index,
    required this.providerId,
    required this.providerName,
    required this.issueDate,
    required this.expiryDate,
    this.onEdit,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Professional Insurance $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "Provider ID:", "value": providerId },
        { "label": "Provider Name:", "value": providerName },
        { "label": "Issue Date:", "value": issueDate },
        { "label": "Expiry Date:", "value": expiryDate },
      ],
    );
  }
}
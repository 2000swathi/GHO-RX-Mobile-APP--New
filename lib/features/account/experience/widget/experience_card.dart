import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class ProfessionalExperienceCard extends StatelessWidget {
  final int index;
  final String institute;
  final String designation;
  final String dateFrom;
  final String dateTo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProfessionalExperienceCard({
    super.key,
    required this.index,
    required this.institute,
    required this.designation,
    required this.dateFrom,
    required this.dateTo,
    this.onEdit,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Education $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "Institute:", "value": institute },
        { "label": "Designation:", "value": designation },
        { "label": "Date From:", "value": dateFrom },
        { "label": "Date To:", "value": dateTo },
      ],

    );
  }
}
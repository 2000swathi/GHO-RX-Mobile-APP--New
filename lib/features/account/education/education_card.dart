import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class EducationCard extends StatelessWidget {
  final int index;
  final String institute;
  final String degree;
  final String duration;
  final String year;
  final String comments;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const EducationCard({
    super.key,
    required this.index,
    required this.institute,
    required this.degree,
    required this.duration,
    required this.year,
    required this.comments,
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
        { "label": "Degree:", "value": degree },
        { "label": "Duration (in years):", "value": duration },
        { "label": "Completed Year:", "value": year },
        { "label": "Comments:", "value": comments },
      ],

    );
  }
}
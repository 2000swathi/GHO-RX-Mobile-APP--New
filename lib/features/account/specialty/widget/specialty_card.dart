import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class SpecialtyCard extends StatelessWidget {
  final int index;
  final String specialty;
  final String certifiedBoard;
  final String specialtyType;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;


  const SpecialtyCard({
    super.key,
    required this.index,
    required this.specialty,
    required this.certifiedBoard,
    required this.specialtyType, 
    this.onEdit,
    this.onDelete,
    });

  @override
   Widget build(BuildContext context) {
    return InfoCard(
      title: "Specialty $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "Specialty:", "value": specialty },
        { "label": "Certified Board:", "value": certifiedBoard },
        { "label": "Specialty Type:", "value": specialtyType },
      ],
    );
  }
}
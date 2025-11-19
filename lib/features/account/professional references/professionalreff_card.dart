import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class ProfessionalRefeCard extends StatelessWidget {
  final int index;
  final String fullnameRefe;
  final String designationRefe;
  final String departRefe;
  final String emailRefe;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProfessionalRefeCard({
    super.key,
    required this.index,
    required this.fullnameRefe,
    required this.designationRefe,
    required this.departRefe,
    required this.emailRefe,
    this.onEdit,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Professional References $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "Full Name:", "value": fullnameRefe },
        { "label": "Designation:", "value": designationRefe },
        { "label": "Department:", "value": departRefe },
        { "label": "Email:", "value": emailRefe },
      ],
    );
  }
}
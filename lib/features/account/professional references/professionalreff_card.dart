import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class ProfessionalRefeCard extends StatelessWidget {
  final int index;
  final String fullnameRefe;
  final String designationRefe;
  // final String designation1Refe;
  final String relationshipRefe;
  final String phoneRefe;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProfessionalRefeCard({
    super.key,
    required this.index,
    required this.fullnameRefe,
    required this.designationRefe,
    // required this.designation1Refe,
    required this.relationshipRefe,
    required this.phoneRefe,
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
        {"label": "Full Name:", "value": fullnameRefe},
        {"label": "Designation:", "value": designationRefe},
        // {"label": "Designation1:", "value": designation1Refe},
        {"label": "Relationship:", "value": relationshipRefe},
        {"label": "phone:", "value": phoneRefe},
      ],
    );
  }
}

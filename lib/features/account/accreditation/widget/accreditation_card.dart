import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/reusable_infocard.dart';

class AccreditationCard extends StatelessWidget {
  final int index;
  final String accreNum;
  final String accreType;
  final String accreBody;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AccreditationCard({
    super.key,
    required this.index,
    required this.accreNum,
    required this.accreType,
    required this.accreBody,
    this.onEdit,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Accreditations $index",
      onEdit: onEdit ?? () {},
      onDelete: onDelete ?? () {},
      fields: [
        { "label": "Accreditation Number:", "value": accreNum },
        { "label": "Accreditation Type:", "value": accreType },
        { "label": "Accreditation Body:", "value": accreBody },
      ],

    );
  }
}
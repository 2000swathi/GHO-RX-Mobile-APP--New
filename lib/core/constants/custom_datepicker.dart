import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> showCommonDatePicker({
  required BuildContext context,
  required TextEditingController controller,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  FocusScope.of(context).unfocus();
  final now = DateTime.now();

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(now.year + 20),
  );

  if (pickedDate != null) {
    final formattedDate =
       DateFormat('dd MMM yyyy').format(pickedDate);
    controller.text = formattedDate;
  }
}

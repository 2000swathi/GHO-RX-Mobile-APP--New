import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

Future<bool?> showDeleteConfirmationDialog({
  required BuildContext context,
  String title = "Delete Confirmation",
  String content = "Are you sure want to delete this item?",
  String cancelText = "Cancel",
  String deleteText = "Delete",
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(title,
      style: AppFonts.subheading.copyWith(
        fontSize: 20
      ),
      ),
      content: Text(content,
      style: AppFonts.subtext,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 231, 37, 37),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(deleteText,
          style: TextStyle(
            color: AppColors.white
          ),
          ),
        ),
      ],
    ),
  );
}

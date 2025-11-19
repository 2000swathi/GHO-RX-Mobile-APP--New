import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;

  const CustomFAB({
    super.key,
    this.onAdd,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            FloatingActionButton(
              heroTag: "edit_fab",
              onPressed: onEdit,
              backgroundColor: AppColors.white,
              elevation: 2,
              child: SvgPicture.asset(
                "assets/svg/account/pencil.svg",
                height: 20,
                width: 20,
                color: AppColors.primarycolor,
              ),
            ),
      
          const SizedBox(width: 10),
      
          if (onAdd != null)
            FloatingActionButton(
              heroTag: "add_fab",
              onPressed: onAdd,
              backgroundColor: AppColors.primarycolor,
              elevation: 2,
              child: Icon(
                Icons.add,
                size: 28,  
                color: AppColors.white,
              ),
            ),
        ],
      ),
    );
  }
}

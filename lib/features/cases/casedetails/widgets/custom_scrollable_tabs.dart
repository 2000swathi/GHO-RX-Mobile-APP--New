import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomScrollableTabs extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTabSelected;
  final int initialIndex;

  const CustomScrollableTabs({
    super.key,
    required this.tabs,
    this.onTabSelected,
    this.initialIndex = 0,
  });

  @override
  State<CustomScrollableTabs> createState() => _CustomScrollableTabsState();
}

class _CustomScrollableTabsState extends State<CustomScrollableTabs> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tabLabel = entry.value;
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTabSelected?.call(index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              padding: EdgeInsets.symmetric( vertical: 10,horizontal: 3),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.lightBlueColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  tabLabel,
                  style: AppFonts.subtext.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? AppColors.primarycolor
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
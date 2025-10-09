import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class CustomScrollableTabs extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTabSelected;
  final int initialIndex;
  final bool useBoxStyle; // 👈 condition to switch UI styles

  const CustomScrollableTabs({
    super.key,
    required this.tabs,
    this.onTabSelected,
    this.initialIndex = 0,
    this.useBoxStyle = false, // 👈 default: original TabBar style
  });

  @override
  State<CustomScrollableTabs> createState() => _CustomScrollableTabsState();
}

class _CustomScrollableTabsState extends State<CustomScrollableTabs>
    with SingleTickerProviderStateMixin {
  late int selectedIndex;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => selectedIndex = _tabController.index);
        widget.onTabSelected?.call(selectedIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.useBoxStyle ? 45 : 40,
      color: Colors.white,
      child: widget.useBoxStyle
          ? _buildBoxStyledTabs() 
          : _buildDefaultTabs(), 
    );
  }


  Widget _buildBoxStyledTabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.primarycolor,
          width: 2,
        ),
      ),
      
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      tabs: List.generate(widget.tabs.length, (index) {
        final bool isSelected = index == selectedIndex;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primarycolor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.tabs[index],
            style: TextStyle(
              color: isSelected
                  ? AppColors.primarycolor
                  : AppColors.textPrimary.withOpacity(0.7),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        );
      }),
    );
  }
  Widget _buildDefaultTabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: AppColors.primarycolor,
      unselectedLabelColor: AppColors.textPrimary,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      indicatorColor: AppColors.primarycolor,
      indicatorWeight: 2.2,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabs: widget.tabs.map((text) => Tab(text: text)).toList(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

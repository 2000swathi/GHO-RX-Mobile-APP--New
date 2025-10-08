import 'package:flutter/material.dart';

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
      if (_tabController.indexIsChanging == false) {
        setState(() => selectedIndex = _tabController.index);
        widget.onTabSelected?.call(selectedIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.black87,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        indicatorColor: Colors.blueAccent,
        indicatorWeight: 2.2,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: widget.tabs.map((text) => Tab(text: text)).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

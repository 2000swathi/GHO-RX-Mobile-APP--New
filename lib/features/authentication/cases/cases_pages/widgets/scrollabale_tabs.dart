import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomScrollableTabs extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTabSelected;
  final int initialIndex;
  final bool useBoxStyle;
  final int? selectedIndex; // ✅ new

  const CustomScrollableTabs({
    super.key,
    required this.tabs,
    this.onTabSelected,
    this.initialIndex = 0,
    this.useBoxStyle = false,
    this.selectedIndex, // ✅ new
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

  // ✅ Add this
  @override
  void didUpdateWidget(CustomScrollableTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != null &&
        widget.selectedIndex != selectedIndex &&
        widget.selectedIndex! < _tabController.length) {
      selectedIndex = widget.selectedIndex!;
      _tabController.animateTo(selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.useBoxStyle ? 45 : 40,
      color: AppColors.hint2color.withAlpha(2),
      child: widget.useBoxStyle ? _buildBoxStyledTabs() : _buildDefaultTabs(),
    );
  }

  Widget _buildBoxStyledTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.hint2color, width: 1.0),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        dividerColor: Colors.transparent,
        indicator: _DualIndicator(
          backgroundColor: AppColors.lightBlueColor,
          underlineColor: AppColors.primarycolor,
          borderRadius: BorderRadius.circular(8),
          underlineHeight: 2,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: List.generate(widget.tabs.length, (index) {
          return Tab(
            child: Text(
              widget.tabs[index],
              style: AppFonts.subtext.copyWith(
                fontWeight:
                    index == selectedIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                color:
                    index == selectedIndex
                        ? AppColors.primarycolor
                        : AppColors.textSecondary,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDefaultTabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: AppColors.primarycolor,
      unselectedLabelColor: AppColors.textPrimary,
      labelStyle: AppFonts.subheading16.copyWith(fontSize: 14),
      unselectedLabelStyle: AppFonts.subtext,
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

class _DualIndicator extends Decoration {
  final Color backgroundColor;
  final Color underlineColor;
  final double underlineHeight;
  final BorderRadius borderRadius;

  const _DualIndicator({
    required this.backgroundColor,
    required this.underlineColor,
    required this.underlineHeight,
    required this.borderRadius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DualPainter(
      backgroundColor: backgroundColor,
      underlineColor: underlineColor,
      underlineHeight: underlineHeight,
      borderRadius: borderRadius,
    );
  }
}

class _DualPainter extends BoxPainter {
  final Color backgroundColor;
  final Color underlineColor;
  final double underlineHeight;
  final BorderRadius borderRadius;

  _DualPainter({
    required this.backgroundColor,
    required this.underlineColor,
    required this.underlineHeight,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Rect rect = offset & cfg.size!;
    final Paint bgPaint = Paint()..color = backgroundColor;

    final RRect rRect = RRect.fromRectAndRadius(rect, borderRadius.topLeft);
    canvas.drawRRect(rRect, bgPaint);

    final Paint linePaint =
        Paint()
          ..color = underlineColor
          ..strokeWidth = underlineHeight
          ..style = PaintingStyle.fill;

    final double y = rect.bottom - underlineHeight / 2;
    canvas.drawLine(Offset(rect.left, y), Offset(rect.right, y), linePaint);
  }
}

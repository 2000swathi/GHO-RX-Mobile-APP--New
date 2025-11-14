import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/month/bloc/month_bloc.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/widget/shapes.dart';

class DailyPaymentGraph extends StatefulWidget {
  DailyPaymentGraph({super.key});

  @override
  State<DailyPaymentGraph> createState() => _DailyPaymentGraphState();
}

class _DailyPaymentGraphState extends State<DailyPaymentGraph> {
  String? _selectedDuration;
  final Map<int, double> payments = {
    1: 1500.0,
    2: 2300.0,
    3: 1800.0,
    4: 2200.0,
    5: 2000.0,
    6: 2500.0,
    7: 1900.0,
    8: 3000.0,
    9: 1700.0,
    10: 2100.0,
    11: 2800.0,
    12: 2600.0,
    13: 3100.0,
    14: 2900.0,
  };
  final Map<int, String> monthNames = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  @override
  void initState() {
    super.initState();
    context.read<MonthBloc>().add(FetchMonthEvent());
  }

  @override
  Widget build(BuildContext context) {
    final spots =
        payments.entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Analytics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Listen to HomeBloc for dropdown items
            SizedBox(
              width: 150,
              child: BlocBuilder<MonthBloc, MonthState>(
                builder: (context, state) {
                  if (state is MonthFailure) {
                    return Center(
                      child: ShimmerShapes.line(width: 130, height: 20),
                    );
                  }

                  if (state is MonthScuccess) {
                    final List<DropdownItem<String>> durationItems =
                        (state.response["Data"][0] as List)
                            .map(
                              (item) => DropdownItem<String>(
                                value: item["D"].toString(),
                                label: item["T"].toString(),
                              ),
                            )
                            .toList();

                    final defaultItem = durationItems.firstWhere(
                      (item) => item.label.toLowerCase().contains('7'),
                      orElse: () => durationItems.first,
                    );

                    if (_selectedDuration == null) {
                      _selectedDuration = defaultItem.value;
                    }

                    return RangeDropdownFormField<String>(
                      name: '',
                      hintText: 'Select Duration',
                      items: durationItems,
                      value: _selectedDuration,
                      onChanged: (value) {
                        setState(() => _selectedDuration = value);
                      },
                      validator:
                          (value) =>
                              value == null ? 'Please select a duration' : null,
                    );
                  }

                  if (state is MonthFailure) {
                    return Text(
                      'Failed to load durations',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 310,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LineChart(
              LineChartData(
                minX: 1,
                maxX: 12,
                minY: 0,
                maxY: 5000,
                //  payments.values.reduce((a, b) => a > b ? a : b) * 1.2,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine:
                      (value) =>
                          FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1000,
                      reservedSize: 45,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1, // each month
                      getTitlesWidget: (value, meta) {
                        final month = monthNames[value.toInt()];
                        return Text(
                          month ?? '',
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primarycolor,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primarycolor.withAlpha(5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 5, backgroundColor: AppColors.primarycolor),
            SizedBox(width: 6),
            Text(
              "Payment received",
              style: TextStyle(color: AppColors.primarycolor, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class RangeDropdownFormField<T> extends StatefulWidget {
  final String name;
  final String hintText;
  final List<DropdownItem<T>> items;
  final T? value;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  const RangeDropdownFormField({
    super.key,
    required this.name,
    required this.hintText,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  State<RangeDropdownFormField<T>> createState() =>
      _RangeDropdownFormFieldState<T>();
}

class _RangeDropdownFormFieldState<T> extends State<RangeDropdownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.name.isNotEmpty)
          Text(widget.name, style: AppFonts.textSecondary),
        if (widget.name.isNotEmpty) const SizedBox(height: 8),

        SizedBox(
          // height: 30,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField2<T>(
                isExpanded: true,
                value:
                    widget.items.any((e) => e.value == widget.value)
                        ? widget.value
                        : null,

                onChanged: widget.onChanged,
                validator: widget.validator,
                hint: Text(
                  widget.hintText,
                  style: AppFonts.hinttext.copyWith(fontSize: 14),
                ),

                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),

                buttonStyleData: const ButtonStyleData(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                ),

                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, size: 18),
                ),

                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                items:
                    widget.items
                        .map(
                          (item) => DropdownMenuItem<T>(
                            value: item.value,
                            child: Text(
                              item.label,
                              style: AppFonts.textprimary.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================
/// Dropdown Item Model
/// =======================
class DropdownItem<T> {
  final T value;
  final String label;

  DropdownItem({required this.value, required this.label});
}

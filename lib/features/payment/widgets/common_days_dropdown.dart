import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_event.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';

class KPIHeader2 extends StatefulWidget {
  const KPIHeader2({super.key});

  @override
  State<KPIHeader2> createState() => _KPIHeader2State();
}

class _KPIHeader2State extends State<KPIHeader2> {
  String? _selectedDuration;

  @override
  void initState() {
    super.initState();
    // Fetch API data for date ranges
    context.read<DateRangeBloc>().add(FetchDateRangeInfo());
    context.read<KeyPerformanceBloc>().add(KeyPerEvent(dateValue: "7"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Recent Transactions",
              style: AppFonts.subtext.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            // Listen to HomeBloc for dropdown items
            SizedBox(
              width: 150,
              child: BlocBuilder<DateRangeBloc, DateRangeState>(
                builder: (context, state) {
                  if (state is HomePageLoading) {
                    return const Center(child: LoadingAnimation());
                  }

                  if (state is DateRangeInfoState) {
                    final List<DropdownItem<String>> durationItems =
                        (state.response["Data"][0] as List)
                            .map(
                              (item) => DropdownItem<String>(
                                value: item["ID"].toString(),
                                label: item["Txt"].toString(),
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
                        setState(() {
                          _selectedDuration = value;
                          context.read<KeyPerformanceBloc>().add(
                            KeyPerEvent(dateValue: value.toString()),
                          );
                        });
                      },
                      validator:
                          (value) =>
                              value == null ? 'Please select a duration' : null,
                    );
                  }

                  if (state is HomePageError) {
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
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
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

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/widget/key_performance_shimmer.dart';

class KPIHeader extends StatefulWidget {
  const KPIHeader({super.key});

  @override
  State<KPIHeader> createState() => _KPIHeaderState();
}

class _KPIHeaderState extends State<KPIHeader> {
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
              "Key Performance Indicators",
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
        const SizedBox(height: 15),
        BlocBuilder<KeyPerformanceBloc, KeyPerformanceState>(
          builder: (context, state) {
            if (state is KeyPerformanceLoading) {
              return Column(children: [Center(child: KeyPerformanceShimmer())]);
            } else if (state is KeyPerformanceFailure) {
              return Center(child: Text(state.message));
            } else if (state is KeyPerformanceSuccess) {
              final response = state.response;
              final data = response["Data"];
              if (data != null || data.isNotEmpty || data[0].isNotEmpty) {
                final data1 = response["Data"][0][0];
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonContainer(
                            borderColor: const Color(0xff667EFA).withAlpha(33),
                            color: const Color(0xff667EFA).withAlpha(5),
                            textColor: const Color(0xff384EC1),
                            data: "Total Review",
                            data1: data1["TotalReview"].toString(),

                            data2Color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CommonContainer(
                            borderColor: const Color(0xffFF8A65).withAlpha(48),
                            color: const Color(0xffFF8A65).withAlpha(10),
                            textColor: const Color(0xffB93106),
                            data: "Open Review",
                            data1: data1["PendingReview"].toString(),

                            data2Color: const Color(0xff39393A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: CommonContainer(
                            borderColor: const Color(0xffC5EFC8),
                            color: const Color(0xffF1FFF2),
                            textColor: const Color(0xff146B1A),
                            data: "Total Revenue",
                            data1: data1["Totalrevenue"].toString(),

                            data2Color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CommonContainer(
                            borderColor: const Color(0xffCCCDCD),
                            color: const Color(0xffF4F5F7),
                            textColor: const Color(0xff404040).withAlpha(48),
                            data: "Next Payout",
                            data1: data1["NextPayout"].toString(),
                            data2Color: const Color(0xff94989B),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
            return SizedBox();
          },
        ),
        const SizedBox(height: 20),
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
          height: 30,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColors.offgreycolor,
              borderRadius: BorderRadius.circular(30),
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

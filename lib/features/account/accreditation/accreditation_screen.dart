import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class AccreditationScreen extends StatefulWidget {
  const AccreditationScreen({super.key});

  @override
  State<AccreditationScreen> createState() => _AccreditationScreenState();
}

class _AccreditationScreenState extends State<AccreditationScreen> {
  final List<Map<String, dynamic>> selectedAccre = [];

  @override
  void initState() {
    super.initState();
    context.read<ListBloc>().add(FetchAccrediationList());
    context.read<AccreditationBloc>().add(FetchAccreditation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: const CustomAccountAppBar(title: "Accreditation"),

      body: MultiBlocListener(
        listeners: [
          BlocListener<AccreditationBloc, AccreditationState>(
            listener: (context, state) {
              if (state is AccreditationgetState) {
                // Only update selectedAccre if we have valid data from a successful API response
                if (state.accreditationModel.status == 1) {
                  selectedAccre
                    ..clear()
                    ..addAll(
                      state.accreditationModel.data.map(
                        (e) => {"id": e.id, "name": e.accreditationType},
                      ),
                    );
                  setState(() {});
                }
              }
            },
          ),
        ],
        child: BlocBuilder<ListBloc, ListState>(
          builder: (context, state) {
            if (state is ListLoading) {
              return const Center(child: LoadingAnimation());
            }

            if (state is ListFailure) {
              return Center(child: Text(state.error));
            }

            if (state is AccreditationTypeListState) {
              final allAccreditation =
                  state.accreditationTypeResponse.data
                      .expand((e) => e)
                      .toList();

              if (allAccreditation.isEmpty) {
                return const Center(
                  child: Text("No accreditation data available"),
                );
              }

              final selected =
                  allAccreditation.where((item) {
                    return selectedAccre.any((e) => e["name"] == item.degree);
                  }).toList();

              final unselected =
                  allAccreditation.where((item) {
                    return !selectedAccre.any((e) => e["name"] == item.degree);
                  }).toList();

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selected.isNotEmpty) ...[
                        Text(
                          "Selected Accreditation",
                          style: AppFonts.textprimary.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children:
                              selected.map((item) {
                                return accreditationItem(
                                  name: item.degree,
                                  id: item.id,
                                  isSelected: true,
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      Text(
                        "Available Accreditation",
                        style: AppFonts.textprimary.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: unselected.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.5,
                            ),
                        itemBuilder: (context, index) {
                          final item = unselected[index];
                          return accreditationItem(
                            name: item.degree,
                            id: item.id,
                            isSelected: false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// Accreditation chip
  Widget accreditationItem({
    required String name,
    required int id,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedAccre.removeWhere((e) => e["name"] == name);
          } else {
            selectedAccre.add({"id": id, "name": name});
          }
        });
        context.read<AccreditationBloc>().add(
          SaveAccreditationEvent(
            accreditationtype: name,
            accreditationbody: name,
          ),
        );
        CustomScaffoldMessenger.showCommonMessage(context, "$name saved");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (_) {
              setState(() {
                if (isSelected) {
                  selectedAccre.removeWhere((e) => e["name"] == name);
                  context.read<DeleteBloc>().add(
                    DeleteProfileItem(
                      id: id.toString(),
                      action: "revieweraccred",
                    ),
                  );
                } else {
                  selectedAccre.add({"id": id, "name": name});
                  context.read<AccreditationBloc>().add(
                    SaveAccreditationEvent(
                      accreditationtype: name,
                      accreditationbody: name,
                    ),
                  );
                  CustomScaffoldMessenger.showCommonMessage(
                    context,
                    "$name saved",
                  );
                }
              });
            },
            activeColor: AppColors.primarycolor,
          ),
          Flexible(
            child: Text(
              name,
              style: AppFonts.textprimary.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

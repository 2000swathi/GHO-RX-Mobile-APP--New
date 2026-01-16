import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/model/accreditationsmodel.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class AccreditationScreen extends StatefulWidget {
  const AccreditationScreen({super.key});

  @override
  State<AccreditationScreen> createState() => _AccreditationScreenState();
}

class _AccreditationScreenState extends State<AccreditationScreen> {
  final List<Map<String, dynamic>> selectedAccre = [];
  List<AccreditationData> _allAccreditations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccreditationBloc>().add(FetchAccreditation());
    });
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
                if (state.accreditationModel.status == 1) {
                  _allAccreditations = state.accreditationModel.data;
                  final selectedItems = state.accreditationModel.data
                      .where((e) => e.id != 0 && e.id.toString() != '0')
                      .map((e) => {"id": e.id, "name": e.name});
                  selectedAccre.clear();
                  selectedAccre.addAll(selectedItems);
                  setState(() {});
                }
              } else if (state is AccSuccess) {
                context.read<AccreditationBloc>().add(FetchAccreditation());
              }
            },
          ),
        ],
        child: BlocBuilder<AccreditationBloc, AccreditationState>(
          builder: (context, state) {
            if (state is AccrediationLoading && _allAccreditations.isEmpty) {
              return const Center(child: LoadingAnimation());
            }

            if (state is AccrediationError && _allAccreditations.isEmpty) {
              return Center(child: Text(state.message));
            }

            if (_allAccreditations.isNotEmpty) {
              final allAccreditation = _allAccreditations;

              final selected = selectedAccre.map((e) {
                return allAccreditation.firstWhere(
                  (element) => element.name == e['name'],
                  orElse: () => AccreditationData(id: e['id'], name: e['name']),
                );
              }).toList();

              final unselected = allAccreditation.where((item) {
                return !selectedAccre.any((e) => e["name"] == item.name);
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
                                  name: item.name,
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
                            name: item.name,
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
    required dynamic id,
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
          AddAccreditationEvent(accreditationName: name),
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
                    AddAccreditationEvent(accreditationName: name),
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

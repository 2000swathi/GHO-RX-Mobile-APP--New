import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/non_disclosure/repo/bloc/nondisclosure_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class NonDisclosureScreen extends StatefulWidget {
  const NonDisclosureScreen({super.key});

  @override
  State<NonDisclosureScreen> createState() => _NonDisclosureScreenState();
}

class _NonDisclosureScreenState extends State<NonDisclosureScreen> {
  List<Map<String, dynamic>> conditions = [];
  Map<String, bool> selectedMap = {};

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NondisclosureBloc>().add(FetchNonDisclosureEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Non-Disclosure & Confidentiality"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MultiBlocListener(
          listeners: [
            BlocListener<NondisclosureBloc, NondisclosureState>(
              listener: (context, state) {
                if (state is NondisclosureSuccess) {
                  setState(() {
                    final dataList = state.data["Data"];
                    if (dataList == null || dataList.isEmpty) {
                      return;
                    }

                    conditions = List<Map<String, dynamic>>.from(
                      dataList[0] ?? [],
                    );

                    for (final q in conditions) {
                      final id = q["id"].toString();
                      final answer = q["Answer"];

                      if (answer != null && answer != "") {
                        selectedMap[id] = answer == "1";
                      } else if (!selectedMap.containsKey(id)) {
                        selectedMap[id] = false;
                      }
                    }
                  });
                }
              },
            ),

            BlocListener<NondisclosureBloc, NondisclosureState>(
              listener: (context, state) {
                if (state is NondisclosureSuccess ||
                    state is NonDisclosureError) {
                  setState(() {});
                }
              },
            ),
          ],
          child: BlocBuilder<NondisclosureBloc, NondisclosureState>(
            builder: (context, state) {
              if (state is NondisclosureLoading && conditions.isEmpty) {
                return const Center(child: LoadingAnimation());
              }

              if (state is NonDisclosureError) {
                return Center(child: Text(state.message));
              }

              if (conditions.isNotEmpty) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: conditions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final q = conditions[index];
                    final id = q["id"].toString();

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: selectedMap[id] ?? false,
                          activeColor: AppColors.primarycolor,
                          onChanged: (value) {
                            final isCecked = value ?? false;

                            setState(() {
                              selectedMap[id] = isCecked;
                            });

                            context.read<NondisclosureBloc>().add(
                              AddNonDisclosureEvent(
                                id: id,
                                value: isCecked ? '1' : '0',
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              q["Question"] ?? "",
                              style: AppFonts.textprimary.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
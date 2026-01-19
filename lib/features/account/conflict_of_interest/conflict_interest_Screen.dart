  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
  import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
  import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
  import 'package:ghorx_mobile_app_new/features/account/conflict_of_interest/repo/bloc/conflict_interest_bloc.dart';
  import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

  class ConflictInterestScreen extends StatefulWidget {
    const ConflictInterestScreen({super.key});

    @override
    State<ConflictInterestScreen> createState() => _ConflictInterestScreenState();
  }

  class _ConflictInterestScreenState extends State<ConflictInterestScreen> {
    List<Map<String, dynamic>> questions = [];
    final Map<String, bool> selectedMap = {};

    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ConflictInterestBloc>().add(FetchConflictInterestEvent());
      });
    }

    bool _checkboxValue(Map<String, dynamic> q) {
      final qid = q["qid"];

      if (qid != null && qid != 0) return true;

      final answer = q["Answer"];
      if (answer == null) return false;

      final v = answer.toString().toLowerCase();
      return v == '1' || v == 'yes' || v == 'true';
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: CustomAccountAppBar(title: "Conflict of Interest"),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocListener<ConflictInterestBloc, ConflictInterestState>(
              listener: (context, state) {
                if (state is ConflictInterestSuccess) {
                    final dataList = state.data["Data"];
                    if (dataList == null || dataList.isEmpty)
                      return;
          
                  final allquestions = List<Map<String, dynamic>>.from(dataList[0]);
                    setState(() {
                      questions = allquestions;
                      for (final q in questions) {
                      final id = q["id"].toString();
                      selectedMap.putIfAbsent(
                        id,
                        () => _checkboxValue(q),
                      );
                    }
                    });
                }
              },
              child: BlocBuilder<ConflictInterestBloc, ConflictInterestState>(
                builder: (context, state) {
                  if (state is ConflictInterestLoading && questions.isEmpty) {
                    return const Center(child: LoadingAnimation());
                  }
          
                  if (state is ConflictInterestError) {
                    return Center(child: Text(state.message));
                  }
          
                  if (questions.isNotEmpty) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: questions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final q = questions[index];
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
          
                                context.read<ConflictInterestBloc>().add(
                                  AddConflictInterestEvent(
                                    conflictId: id,
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
        ),
      );
    }
  }

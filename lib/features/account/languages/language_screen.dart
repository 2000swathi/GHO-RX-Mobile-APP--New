import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/bloc/language_bloc.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, dynamic>> selectedLanguages = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListBloc>().add(FetchLangList());
      context.read<LanguageBloc>().add(FetchLanguage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Languages"),

      body: MultiBlocListener(
        listeners: [
          BlocListener<LanguageBloc, LanguageState>(
            listener: (context, state) {
              if (state is Language) {
                selectedLanguages
                  ..clear()
                  ..addAll(
                    state.languageModel.data.map(
                      (e) => {"id": e.id, "language": e.language},
                    ),
                  );

                setState(() {});
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

            if (state is LanguageLIstState) {
              final languages = state.response["Data"][0];

              final List<String> allLanguages =
                  languages
                      .map<String>((lang) => lang["DataValue"] as String)
                      .toList();

              final List<String> selected =
                  allLanguages.where((lang) {
                    return selectedLanguages.any(
                      (item) => item["language"] == lang,
                    );
                  }).toList();

              final List<String> unselected =
                  allLanguages.where((lang) {
                    return !selectedLanguages.any(
                      (item) => item["language"] == lang,
                    );
                  }).toList();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selected.isNotEmpty)
                        Text(
                          "Selected Languages",
                          style: AppFonts.textprimary.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                      if (selected.isNotEmpty)
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children:
                              selected.map((name) {
                                final item = selectedLanguages.firstWhere(
                                  (e) => e["language"] == name,
                                );

                                return languageItem(name, item["id"], true);
                              }).toList(),
                        ),

                      const SizedBox(height: 20),

                      Text(
                        "Available Languages",
                        style: AppFonts.textprimary.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: unselected.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, 
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12, 
                              childAspectRatio:
                                  2.5, 
                            ),
                        itemBuilder: (context, index) {
                          final name = unselected[index];
                          return languageItem(name, 0, false);
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

  /// ------------------------------------------------------------
  /// LANGUAGE ITEM → IMMEDIATE API CALL ON SELECT / UNSELECT
  /// ------------------------------------------------------------
  Widget languageItem(String name, int id, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedLanguages.removeWhere((e) => e["language"] == name);
          } else {
            selectedLanguages.add({"id": id, "language": name});
          }
        });

        context.read<LanguageBloc>().add(AddLanguage(language: name));

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
                  selectedLanguages.removeWhere((e) => e["language"] == name);
                  context.read<DeleteBloc>().add(
                    DeleteProfileItem(
                      id: id.toString(),
                      action: "reviewerlang",
                      isLang: true,
                    ),
                  );
                } else {
                  selectedLanguages.add({"id": id, "language": name});
                  context.read<LanguageBloc>().add(AddLanguage(language: name));
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

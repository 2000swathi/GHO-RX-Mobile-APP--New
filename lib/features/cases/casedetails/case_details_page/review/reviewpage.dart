import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/recordaudio.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/get_file_id_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/summary/writtenreport.dart';

class Reviewpage extends StatefulWidget {
  String saltID;
  String summaryRecords;
  String caseID;
  List<AudioSummaryModel>? audioSummaryModel;
  Reviewpage({
    super.key,
    required this.saltID,
    required this.summaryRecords,
    required this.caseID,
    required this.audioSummaryModel,
  });

  @override
  State<Reviewpage> createState() => _ReviewpageState();
}

class _ReviewpageState extends State<Reviewpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goToNextTab() {
    FocusScope.of(context).unfocus();
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint1color.withAlpha(15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.hint2color, width: 1.0),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.primarycolor,
                  width: 2.0,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 1.0),
              ),
              labelColor: AppColors.primarycolor,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Type Written Report*'),
                Tab(text: 'Attach / Record Audio'),
              ],
            ),
          ),

          // 🔹 Tab content
          Container(
            constraints: const BoxConstraints(minHeight: 300),
            child: Stack(
              children: [
                Visibility(
                  visible: _tabController.index == 0,
                  maintainState: true,
                  child: Writtenreport(
                    onNext: _goToNextTab,
                    saltID: widget.saltID,
                    summaryRecords: widget.summaryRecords,
                  ),
                ),
                Visibility(
                  visible: _tabController.index == 1,
                  maintainState: true,
                  child: BlocProvider(
                    create: (_) => GetFileIdBloc(repository: GetFileIDReo()),
                    child: Recordaudio(
                      caseID: widget.caseID,
                      audioSummaryModel: widget.audioSummaryModel,
                      saltID: widget.saltID,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

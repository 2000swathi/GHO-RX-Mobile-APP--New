import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/get_files_icons.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class ReportListWidget extends StatelessWidget {
  final List<AudioSummaryModel> fileList;
  final int itemCount;
  final bool? isDrUploaded;

  const ReportListWidget({
    Key? key,
    required this.fileList,
    required this.itemCount,
    this.isDrUploaded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final report = fileList[index];
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primarycolor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withAlpha(5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: SvgPicture.asset(
                    GetFilesandIcons.getFileIcon(report.fileName),
                    width: 24,
                    height: 24,
                  ),
                  title: Text(report.fileName, style: AppFonts.subheading16),
                  onTap: () async {
                    try {
                      await GetFilesandIcons.openDocument(report.url);
                    } catch (e) {
                      CustomScaffoldMessenger.showErrorMessage(
                        context,
                        "Could not open document",
                      );
                    }
                  },
                ),
              ),
            ),
            isDrUploaded == true
                ? IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/svg/trash.svg"))
                : SizedBox(),
          ],
        );
      },
    );
  }
}

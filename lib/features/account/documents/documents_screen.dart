import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/recent_uploadTile.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/uploadfiles_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({super.key});

  final recentUploads = [
    {
        "name": "document_1.pdf",
        "size": "2.4 MB",
        "time": "Just now",
        "icon": Icons.insert_drive_file,
      },
      {
        "name": "image_preview.jpg",
        "size": "1.8 MB",
        "time": "5 mins ago",
        "icon": Icons.image,
      },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Upload Documents",
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
        child: CustomButton(
          text: "Upload More Files",
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
                "Upload your documents to the cloud",
                style: AppFonts.hinttext2,
              ),
            SizedBox(height: 20),
            UploadfilesCard(),
            SizedBox(height: 30),
            Text("Recent Uploads",
            style: AppFonts.subheading,
            ),
            SizedBox(height: 20),
            ListView.separated(
              itemCount: recentUploads.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final file = recentUploads[index];
                return RecentUploadTile(
                  fileName: file["name"] as String, 
                  size: file["size"] as String, 
                  time: file["time"] as String, 
                  icon: file["icon"] as IconData,
                ); 
              }
            ),
            SizedBox(height: 10),
          ],
        ),
      )
    );
  }
}
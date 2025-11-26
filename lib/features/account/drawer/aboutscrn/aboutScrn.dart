import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/links.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';

class Aboutscrn extends StatefulWidget {
  const Aboutscrn({super.key});

  @override
  State<Aboutscrn> createState() => _AboutscrnState();
}

class _AboutscrnState extends State<Aboutscrn> {
  String appName = '';
  String version = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = info.appName;
      version = '${info.version}+${info.buildNumber}';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About", style: AppFonts.subheading16),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isLoading ? _buildShimmer() : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ NORMAL CONTENT
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoTile("App Name", appName),
        const SizedBox(height: 15),
        _infoTile("Version", version),
        const SizedBox(height: 25),

        const Divider(),

        const SizedBox(height: 10),

        _linkTile(
          title: "Privacy Policy",
          onTap: () {
            Links().privacyPolicy();
          },
        ),
        const SizedBox(height: 10),

        _linkTile(
          title: "Terms & Conditions",
          onTap: () {
            Links().termsAndConditions();
          },
        ),
      ],
    );
  }

  /// ✅ SHIMMER UI
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerLine(width: 100, height: 16),
          const SizedBox(height: 8),
          _shimmerLine(width: double.infinity, height: 14),
          const SizedBox(height: 20),
          _shimmerLine(width: 100, height: 16),
          const SizedBox(height: 8),
          _shimmerLine(width: 150, height: 14),
          const SizedBox(height: 30),
          _shimmerLine(width: double.infinity, height: 40),
          const SizedBox(height: 10),
          _shimmerLine(width: double.infinity, height: 40),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.subtext),
        const SizedBox(height: 4),
        Text(value, style: AppFonts.subheading16),
      ],
    );
  }

  Widget _linkTile({required String title, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppFonts.subheading16),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _shimmerLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

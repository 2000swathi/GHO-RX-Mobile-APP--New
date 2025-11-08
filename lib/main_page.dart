import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/home/home_page.dart';
import 'package:ghorx_mobile_app_new/features/payment/payment_page.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/profile/profile_dr.dart';
import 'package:new_version_plus/new_version_plus.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CasesPage(),
    PaymentPage(),
    ProfileDr(),
  ];

  @override
  void initState() {
    super.initState();
    _checkForAppUpdate();
  }

  Future<void> _checkForAppUpdate() async {
    final newVersion = NewVersionPlus(
      iOSId: 'care.gho.globalHealthOpinionRx',
      androidId: 'in.globalhealthopinionrx',
    );

    final status = await newVersion.getVersionStatus();

    if (status != null && status.canUpdate) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText:
            'A new version (${status.storeVersion}) is available. You’re using ${status.localVersion}. Please update for the latest features.',
        updateButtonText: 'Update Now',
        dismissButtonText: 'Later',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && _currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else if (_currentIndex == 0) {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App?'),
              content: const Text('Do you want to close the app?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
              ],
            ),
          );
          if (shouldExit == true) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.primarycolor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? SvgPicture.asset("assets/svg/homeclick.svg")
                  : SvgPicture.asset("assets/svg/home_svg.svg"),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? SvgPicture.asset("assets/svg/caseclick.svg")
                  : SvgPicture.asset("assets/svg/cases_svg.svg"),
              label: "Cases",
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                 ? SvgPicture.asset("assets/svg/caseclick.svg")
                  : SvgPicture.asset("assets/svg/cases_svg.svg"),
              label: "Payment",
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3
                  ? SvgPicture.asset("assets/svg/profile_clik.svg")
                  : SvgPicture.asset("assets/svg/profile_svg.svg"),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

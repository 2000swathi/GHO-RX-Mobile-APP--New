import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/home/home_page.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/profile_dr.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CasesPage(),
    const ProfileDr(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.primarycolor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:
                _currentIndex == 0
                    ? SvgPicture.asset("assets/svg/homeclick.svg")
                    : SvgPicture.asset("assets/svg/home_svg.svg"),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon:
                _currentIndex == 1
                    ? SvgPicture.asset("assets/svg/caseclick.svg")
                    : SvgPicture.asset("assets/svg/cases_svg.svg"),
            label: "Cases",
          ),
          BottomNavigationBarItem(
            icon:
                _currentIndex == 2
                    ? SvgPicture.asset("assets/svg/profile_clik.svg")
                    : SvgPicture.asset("assets/svg/profile_svg.svg"),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

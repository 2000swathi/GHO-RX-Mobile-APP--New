import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/account_page.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/bloc/open_closed_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/home_page.dart';
import 'package:ghorx_mobile_app_new/features/payment/payment_page.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_bloc.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_event.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_state.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/update_ui.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;   

  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const CasesPage(),
    const PaymentPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    /// 🔥 Trigger update check
    context.read<UpdateBloc>().add(CheckForUpdateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is UpdateAvailable) {
          /// 🔥 SHOW UPDATE UI
          UpdateUIHelper.showUpdateBottomSheet(context);
        }

        if (state is UpdateError) {
          debugPrint("Update error: ${state.message}");
        }
      },

      child: PopScope(
        canPop: _currentIndex == 0,

        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop && _currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
          } else if (_currentIndex == 0) {
            final shouldExit = await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Exit App?'),
                    content: const Text('Do you want to close the app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
            );

            if (shouldExit == true) {
              SystemNavigator.pop();
            }
          }
        },

        child: Scaffold(
          body: IndexedStack(index: _currentIndex, children: _pages),

          bottomNavigationBar: SafeArea(
            top: false,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: AppColors.primarycolor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              type: BottomNavigationBarType.fixed,

              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });

                if (index == 1) {
                  context.read<OpenClosedBloc>().add(FetchOpenCases());
                }
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
                          ? SvgPicture.asset(
                            "assets/svg/payment_click_icon.svg",
                          )
                          : SvgPicture.asset("assets/svg/payment_icon.svg"),
                  label: "Earnings",
                ),

                BottomNavigationBarItem(
                  icon:
                      _currentIndex == 3
                          ? SvgPicture.asset("assets/svg/profile_clik.svg")
                          : SvgPicture.asset("assets/svg/profile_svg.svg"),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

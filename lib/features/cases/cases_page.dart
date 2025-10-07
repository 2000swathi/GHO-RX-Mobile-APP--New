import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';

class CasesPage extends StatelessWidget {
  const CasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CaseAppBar(
        title: "Cases",
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Performance Snapshot",
            style: AppFonts.subheading,
           ),
           SizedBox(height: 20),
           Row(
             children: [
               Expanded(
                flex: 2,
                 child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFEE8F6), Color(0xFFEDE9FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),                  
                  ),
                  child: Text("Overview",
                  style: AppFonts.subheading,
                  ),
                 ),
               ),
             ],
           )
        ],
      )
    );
  }
}

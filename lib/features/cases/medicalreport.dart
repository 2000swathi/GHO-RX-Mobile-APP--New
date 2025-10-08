import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Medicalreport extends StatelessWidget {
  const Medicalreport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           children: [
             const Text(
                'Reports & Imaging Files',
                style: AppFonts.subheading16
              ),
              SizedBox(width: 7,),
               Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('4 Files', style: AppFonts.textprimarygreen12,),
                  ),
           ],
         ),
        ],
      ),
    );
  }
}
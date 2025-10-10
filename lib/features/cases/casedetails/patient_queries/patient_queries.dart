import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PatientQueriesScreen extends StatefulWidget {
  const PatientQueriesScreen({super.key});

  @override
  State<PatientQueriesScreen> createState() => _PatientQueriesScreenState();
}

class _PatientQueriesScreenState extends State<PatientQueriesScreen> {
  final List<String> queries = [
    'Do my symptoms definitely suggest a stroke, or could it be something else?',
    'What risks do I face if I delay admission or treatment?',
    'What treatment options are available for my condition right now?',
    'Based on my reports, what is your recommendation?',
  ];

  int? expandedIndex; // tracks which tile is open

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Text("Patient Queries", style: AppFonts.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: queries.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final isExpanded = expandedIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    title: Text(queries[index], style: AppFonts.buttontxt16),
                    leading: const Icon(
                      Icons.help_outline,
                      color: Colors.blueGrey,
                    ),
                    trailing: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                  ),

                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Response:", style: AppFonts.subheading16),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 15,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Type your answer here",
                                    prefixIcon: Icon(Icons.message_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.offgreycolor.withAlpha(
                                      70,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 8,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primarycolor
                                    .withOpacity(0.1),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "assets/svg/record.svg",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primarycolor
                                    .withOpacity(0.1),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.link,
                                    color: AppColors.primarycolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

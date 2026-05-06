import 'package:flutter/material.dart';

class MedicalHistoryWidget extends StatelessWidget {
  const MedicalHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🔹 MAIN TITLE
          const Text(
            "Medical History",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 FAMILY HISTORY
          const Text(
            "Family History",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Patient has a family history of diabetes and hypertension. Father diagnosed with type 2 diabetes, mother with high blood pressure.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 PREVIOUS SURGERY / HOSPITALIZED
          const Text(
            "Previous Surgery / Hospitalized",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Patient underwent appendix surgery in 2018 and was hospitalized for 3 days. No complications reported.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
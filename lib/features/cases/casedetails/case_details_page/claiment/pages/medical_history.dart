import 'package:flutter/material.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final String? familyHistory;
  final String? previousSurgeryHistory;
  const MedicalHistoryWidget({
    super.key,
    this.previousSurgeryHistory,
    this.familyHistory,
  });

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
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
          Text(
            familyHistory == null || familyHistory.toString().trim().isEmpty
                ? 'No medical history added'
                : familyHistory.toString(),
            style: TextStyle(fontSize: 13, color: Colors.black),
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
          Text(
            previousSurgeryHistory == null ||
                    previousSurgeryHistory.toString().trim().isEmpty
                ? "No previous surgery added"
                : previousSurgeryHistory.toString(),
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

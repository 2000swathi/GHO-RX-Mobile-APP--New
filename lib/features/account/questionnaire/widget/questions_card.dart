import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class QuestionCard extends StatefulWidget {
  final String questionText;
  final String questionId;
  final int index;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ValueChanged<String>? onReasonChanged;
  final String? reason;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.questionId,
    required this.index,
    required this.value,
    required this.onChanged,
    this.onReasonChanged,
    this.reason,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.reason ?? "");
  }

  @override
  void didUpdateWidget(covariant QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reason != oldWidget.reason) {
      _controller.text = widget.reason ?? "";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Index Box
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.index}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// Question Text
                Expanded(
                  child: Text(
                    widget.questionText,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                /// Checkbox
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: widget.value,
                    onChanged: (v) => widget.onChanged(v ?? false),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: AppColors.primarycolor,
                  ),
                ),
              ],
            ),

            /// Reason TextField if 'Yes' checked
            if (widget.value) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                onChanged: widget.onReasonChanged,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Please explain...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

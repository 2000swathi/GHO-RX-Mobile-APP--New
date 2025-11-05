import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CommonCheckboxDeclaration extends StatefulWidget {
  final String declarationText;
  final String title;
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;

  const CommonCheckboxDeclaration({
    super.key,
    required this.declarationText,
    required this.title,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<CommonCheckboxDeclaration> createState() =>
      _CommonCheckboxDeclarationState();
}

class _CommonCheckboxDeclarationState extends State<CommonCheckboxDeclaration> {
  late bool isChecked;
  bool _isExpanded = false; // Controls "Read more / less"
  bool _showReadMore = false; // Whether to show the toggle link

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void _toggleCheck(bool? value) {
    setState(() => isChecked = value ?? !isChecked);
    widget.onChanged?.call(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: "${widget.title}: ",
      style: AppFonts.buttontxt.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      children: [
        TextSpan(
          text: widget.declarationText,
          style: AppFonts.buttontxt.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 15,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 80);

    _showReadMore = textPainter.didExceedMaxLines;

    return InkWell(
      onTap: () => _toggleCheck(!isChecked),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: _toggleCheck,
            activeColor: AppColors.primarycolor,
            side: BorderSide(color: AppColors.textSecondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: _isExpanded ? null : (_showReadMore ? 10 : null),
                  overflow:
                      _isExpanded
                          ? TextOverflow.visible
                          : (_showReadMore
                              ? TextOverflow.ellipsis
                              : TextOverflow.visible),
                  text: textSpan,
                ),
                if (_showReadMore)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Text(
                        _isExpanded ? "Read less" : "Read more",
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

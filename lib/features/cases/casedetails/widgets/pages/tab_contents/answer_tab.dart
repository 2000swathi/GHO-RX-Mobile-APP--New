import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AnswerTab extends StatefulWidget {
  const AnswerTab({super.key});

  @override
  State<AnswerTab> createState() => _AnswerTabState();
}

class _AnswerTabState extends State<AnswerTab> {
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 200,
          maxHeight: 500,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF3F5F8),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: quill.QuillEditor.basic(controller: _controller),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IgnorePointer(
                        child: ListenableBuilder(
                          listenable: _controller,
                          builder: (context, _) {
                            final isEmpty =
                                _controller.document.toPlainText().trim().isEmpty;
                            return AnimatedOpacity(
                              opacity: isEmpty ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                "Type your answer here (e.g., explanation, \nadvice, next steps)…",
                                style: AppFonts.textprimary.copyWith(
                                  color: AppColors.textPrimary.withAlpha(70),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      
            Divider(thickness: 1, height: 1, color: AppColors.hint2color),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                color: Color(0xffF3F5F8),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 4),
      
                  _toolbarIcon(Icons.format_bold, () {
                    final isBold = _controller
                        .getSelectionStyle()
                        .attributes
                        .keys
                        .contains(quill.Attribute.bold.key);
                    _controller.formatSelection(
                      isBold
                          ? quill.Attribute.clone(quill.Attribute.bold, null)
                          : quill.Attribute.bold,
                    );
                  }),
      
                  _toolbarIcon(Icons.format_italic, () {
                    final isItalic = _controller
                        .getSelectionStyle()
                        .attributes
                        .keys
                        .contains(quill.Attribute.italic.key);
                    _controller.formatSelection(
                      isItalic
                          ? quill.Attribute.clone(quill.Attribute.italic, null)
                          : quill.Attribute.italic,
                    );
                  }),
      
                  _toolbarIcon(Icons.format_underline, () {
                    final isUnderlined = _controller
                        .getSelectionStyle()
                        .attributes
                        .keys
                        .contains(quill.Attribute.underline.key);
                    _controller.formatSelection(
                      isUnderlined
                          ? quill.Attribute.clone(quill.Attribute.underline, null)
                          : quill.Attribute.underline,
                    );
                  }),
      
                  // Builder(
                  //   builder: (_) {
                  //     final align =
                  //         _controller
                  //             .getSelectionStyle()
                  //             .attributes[quill.Attribute.align.key]
                  //             ?.value;
      
                  //     IconData icon;
                  //     if (align == 'center') {
                  //       icon = Icons.format_align_center;
                  //     } else if (align == 'right') {
                  //       icon = Icons.format_align_right;
                  //     } else {
                  //       icon = Icons.format_align_left;
                  //     }
      
                  //     return _toolbarIcon(icon, () {
                  //       if (align == 'left' || align == null) {
                  //         _controller.formatSelection(quill.Attribute.center);
                  //       } else if (align == 'center') {
                  //         _controller.formatSelection(quill.Attribute.right);
                  //       } else {
                  //         _controller.formatSelection(quill.Attribute.left);
                  //       }
      
                  //       setState(() {}); // Refresh toolbar icon
                  //     });
                  //   },
                  // ),
                  _toolbarIcon(Icons.format_list_bulleted, () {
                    final isList = _controller
                        .getSelectionStyle()
                        .attributes
                        .keys
                        .contains(quill.Attribute.ul.key);
                    _controller.formatSelection(
                      isList
                          ? quill.Attribute.clone(quill.Attribute.ul, null)
                          : quill.Attribute.ul,
                    );
                  }),
                  Container(width: 1, height: 24, color: AppColors.hint2color),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        final plainText = _controller.document.toPlainText();
                        debugPrint('Saved content: $plainText');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Answer saved')),
                        );
                      },
                      child: Text(
                        "Save",
                        style: AppFonts.textblue.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toolbarIcon(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.grey[600], size: 22),
        splashRadius: 20,
      ),
    );
  }
}

extension on quill.Document {
  bool isEmpty() {
    return toPlainText().trim().isEmpty;
  }
}

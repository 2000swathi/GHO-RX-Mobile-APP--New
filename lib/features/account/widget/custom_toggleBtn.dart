import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final ValueNotifier<bool> notifier;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  /// NEW: async function that will handle permission + SharedPrefs
  final Future<void> Function()? onToggle;

  const CustomSwitch({
    super.key,
    required this.notifier,
    this.onToggle,
    this.width = 60,
    this.height = 30,
    this.activeColor = const Color(0xFF5D75F0),
    this.inactiveColor = const Color(0xFFE0E0E0),
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isProcessing = false; // Prevents double tap

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_isProcessing) return; // Prevent spam taps

        _isProcessing = true;

        // If user provided function → call that
        if (widget.onToggle != null) {
          await widget.onToggle!();
        }
        // Else fallback to normal toggle
        else {
          widget.notifier.value = !widget.notifier.value;
        }

        _isProcessing = false;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.notifier,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: value ? widget.activeColor : widget.inactiveColor,
              borderRadius: BorderRadius.circular(widget.height),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: widget.height - 8,
                height: widget.height - 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

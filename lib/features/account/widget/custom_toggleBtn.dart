import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> notifier;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSwitch({
    super.key,
    required this.notifier,
    this.width = 60,
    this.height = 30,
    this.activeColor = const Color(0xFF5D75F0), // Your Figma blue
    this.inactiveColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notifier.value = !notifier.value; // toggles ON/OFF
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: width,
            height: height,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: value ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(height),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: height - 8,
                height: height - 8,
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

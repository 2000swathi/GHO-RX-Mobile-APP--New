import 'dart:ui';

import 'package:flutter/material.dart';

class ElevatedGlassBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final double borderRadius;

  const ElevatedGlassBox({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),

        //  Glass Border
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
          width: 1.5,
        ),

        // Elevation Shadow
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.12),
        //     blurRadius: 20,
        //     spreadRadius: 2,
        //     offset: const Offset(0, 10),
        //   ),
        // ],

        // Light gradient
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.06),
            Colors.white.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: child,
        ),
      ),
    );
  }
}

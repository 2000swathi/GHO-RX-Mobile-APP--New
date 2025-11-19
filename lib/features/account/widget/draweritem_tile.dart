import 'package:flutter/material.dart';

class DrawerItemTile extends StatelessWidget {
  final String imagePath;     // SVG icon path
  final String title;
  final VoidCallback? onTap;

  const DrawerItemTile({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              imagePath,
              height: 24,
              width: 24,
      
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: onTap,
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

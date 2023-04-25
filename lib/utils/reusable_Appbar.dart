import 'package:flutter/material.dart';

class DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  DynamicAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // ... other app bar properties
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

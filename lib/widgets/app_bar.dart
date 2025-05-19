
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final Widget icon;
  final String title;
  final List<Widget>? actions;
  const AppBarComponent({
    super.key,
    required this.icon,
    required this.title,
    this.actions
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: icon,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        actions: actions,
    );
  }

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
import 'package:flutter/material.dart';

class CustAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustAppBar({super.key, required this.title});
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  State<CustAppBar> createState() => _CustAppBarState();
}

class _CustAppBarState extends State<CustAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: true,
      title: Text(widget.title),
    );
  }
}

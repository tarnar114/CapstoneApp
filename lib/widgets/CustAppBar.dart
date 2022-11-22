import 'package:flutter/material.dart';

class CustAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: true,
      title: const Text("Home"),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

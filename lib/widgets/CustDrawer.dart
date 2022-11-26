import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
          ),
          title: Text('Home'),
          onTap: () {
            context.go('/');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.alarm,
          ),
          title: const Text('Sessions'),
          onTap: () {
            context.go('/alerts');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
          ),
          title: const Text('Settings'),
          onTap: () {},
        )
      ],
    ));
  }
}

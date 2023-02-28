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
          child: Text(''),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
          ),
          title: Text('Home'),
          onTap: () {
            GoRouter.of(context).go('/');

            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.alarm,
          ),
          title: const Text('Sessions'),
          onTap: () {
            GoRouter.of(context).go('/alerts');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.map,
          ),
          title: const Text('Map'),
          onTap: () {
            Navigator.pop(context);

            GoRouter.of(context).go('/map');
          },
        )
      ],
    ));
  }
}

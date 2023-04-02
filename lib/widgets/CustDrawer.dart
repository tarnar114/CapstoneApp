import 'package:capstone_app/src/THEME/Theme_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:capstone_app/misc/themes.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Text(''),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
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
        ),
        BlocSelector<ThemeCubit, ThemeState, bool>(selector: (state) {
          if (state.data == Themes.darkTheme) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          return ListTile(
              leading: Icon(state ? Icons.mode_night_outlined : Icons.sunny),
              title: state ? Text("Dark mode") : Text("Light Mode"),
              onTap: () {
                final themeCubit = context.read<ThemeCubit>();
                if (state) {
                  themeCubit.switchToLight();
                  themeCubit.state.printTheme();
                } else {
                  themeCubit.switchToDark();
                  themeCubit.state.printTheme();
                }
              });
        })
      ],
    ));
  }
}

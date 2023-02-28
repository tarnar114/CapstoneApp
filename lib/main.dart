// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:capstone_app/Screens/AddAlert.dart';
import 'package:capstone_app/Screens/Onboard.dart';
import 'package:capstone_app/data/AlertStorage.dart';
import 'package:capstone_app/widgets/CustAppBar.dart';
import 'package:capstone_app/widgets/CustDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import './Screens/Home.dart';
import './Screens/Alerts.dart';
import './Screens/Map.dart';

// This scenario demonstrates a simple two-page app.
//
// The first route '/' is mapped to Page1Screen, and the second route '/page2'
// is mapped to Page2Screen. To navigate between pages, press the buttons on the
// pages.
//
// The onPress callbacks use context.go() to navigate to another page. This is
// equivalent to entering url to the browser url bar directly.
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
void main() => runApp(App());

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  App({Key? key}) : super(key: key);

  /// The title of the app.
  static const String title = 'Locker';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: title,
      );

  final GoRouter _router =
      GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
          return NoTransitionPage(
            child: Scaffold(
              appBar: CustAppBar(title: "Locker"),
              drawer: CustDrawer(),
              body: Container(child: child),
            ),
          );
        },
        routes: [
          GoRoute(
              path: '/',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: Home());
              }),
          GoRoute(
              path: '/alerts',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: Alert(
                  storage: AlertStorage(),
                ));
              }),
          GoRoute(
              path: '/map',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: Map());
              }),
        ]),
    GoRoute(
        path: '/onboard',
        builder: ((context, state) {
          return Onboard();
        }))
  ]);
}
//  routes: [
//           GoRoute(
//             path: '/',
//             parentNavigatorKey: _shellNavigatorKey,
//             pageBuilder: (context, state) =>
//                 const NoTransitionPage(child: Home()),
//           )
//         ]
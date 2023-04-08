// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:capstone_app/Screens/AddAlert.dart';
import 'package:capstone_app/src/Socket/bloc/socketBloc.dart';
import 'package:capstone_app/Screens/Onboard.dart';
import 'package:capstone_app/data/AlertStorage.dart';
import 'package:capstone_app/src/THEME/Theme_Cubit.dart';
import 'package:capstone_app/widgets/CustAppBar.dart';
import 'package:capstone_app/widgets/CustDrawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './Screens/Home.dart';
import './Screens/Alerts.dart';
import './Screens/Map.dart';
import 'package:capstone_app/Screens/Scan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

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
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await init();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    print(fcmToken);
  }
  runApp(App());
}

Future<void> init() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //Initialization Settings for Android
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  //InitializationSettings for initializing settings for both platforms (Android & iOS)
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  AndroidNotificationDetails _andrdoidNotifDetails =
      AndroidNotificationDetails("channelId", "channelName");
  NotificationDetails platformChannelSpecs =
      NotificationDetails(android: _andrdoidNotifDetails);
  //change later jesus
  // await flutterLocalNotificationsPlugin.show(
  //     0, 'irit lock', 'ALERT: Your battery is under 20%', platformChannelSpecs,
  //     payload: 'item x');
  // await flutterLocalNotificationsPlugin.show(
  //     1, 'irit lock', 'ALERT:Your lock has auto unlocked', platformChannelSpecs,
  //     payload: 'item x');
  // await flutterLocalNotificationsPlugin.show(
  //     2, 'irit lock', 'ALERT: Your lock has auto locked', platformChannelSpecs,
  //     payload: 'item x');
  // await flutterLocalNotificationsPlugin.show(3, 'irit lock',
  //     'ALERT: Your lock is being tampered with', platformChannelSpecs,
  //     payload: 'item x');
  // await flutterLocalNotificationsPlugin.show(
  //     4, 'irit lock', 'ALERT: Your bike is out of area', platformChannelSpecs,
  //     payload: 'item x');
}

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  App({Key? key, Socket? sock}) : super(key: key);

  /// The title of the app.
  static const String title = 'Irit';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
          BlocProvider<socketBloc>(
            create: (BuildContext context) => socketBloc(),
          )
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _router,
              title: title,
              theme: state.data,
            );
          },
        ));
  }

  final GoRouter _router =
      GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
          return NoTransitionPage(
            child: Scaffold(
              appBar: CustAppBar(title: "Irit"),
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
          GoRoute(
            path: '/add_alert',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: AddAlert(
                storage: AlertStorage(),
              ));
            },
          )
        ]),
    GoRoute(
        path: '/onboard',
        builder: ((context, state) {
          return Onboard();
        })),
    GoRoute(
      path: '/scan',
      builder: (context, state) {
        return Scan();
      },
    )
  ]);
}

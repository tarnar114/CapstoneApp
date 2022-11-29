/// The screen of the first page.
import 'dart:async';
import 'dart:io' show Platform;

///
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../widgets/LockButton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool locked = false;
  bool connected = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustAppBar(),
        drawer: CustDrawer(),
        body: Column(
          children: [
            LockButton(
              callback: _callback,
            ),
          ],
        ),
      );
  void _callback() {
    setState(() {
      if (!connected) {
        connected = !connected;
      } else {
        locked = !locked;
      }
    });
  }

  void connect() {}
}

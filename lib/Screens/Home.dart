/// The screen of the first page.
import 'dart:async';
import 'dart:io' show Platform;

///
import 'package:flutter/material.dart';
import 'package:capstone_app/src/Bluetooth/BLE_CONN.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool locked = false;
  bool connected = false;

  @override
  Widget build(BuildContext context) =>
      Column(children: [LockButton(callback: _callback)]);
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

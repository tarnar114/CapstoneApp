import 'dart:async';

import 'package:capstone_app/src/Socket/bloc/socketBloc.dart';
import 'package:capstone_app/src/Socket/bloc/socketEvent.dart';
import 'package:capstone_app/src/Socket/bloc/socketState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

class LockButton extends StatefulWidget {
  const LockButton({required this.callback, super.key});
  final Function callback;
  @override
  State<LockButton> createState() => LockButtonState();
}

class LockButtonState extends State<LockButton> {
  bool lockState = true;
  bool Connected = true;
  List<Widget> getChild(socketState state) {
    if (Connected) {
      if (lockState == true) {
        return Locked;
      } else {
        return Unlocked;
      }
    } else {
      return disconnected;
    }
  }

  Future<void> lock() async {
    var url = Uri.https(
        'h71wd0a7g1.execute-api.us-east-1.amazonaws.com', '/prod/lock');
    await http.get(
      url,
    );
  }

  List<Widget> disconnected = [
    Icon(
      Icons.signal_wifi_bad,
      size: 50,
    ),
    Text("connect")
  ];

  List<Widget> scanning = [
    Icon(
      Icons.wifi_find_sharp,
      size: 50,
    ),
    Text("Scanning")
  ];

  List<Widget> Locked = [
    Icon(
      Icons.lock,
      size: 50,
    ),
    Text("Lock")
  ];

  List<Widget> Unlocked = [
    Icon(
      Icons.lock_open,
      size: 50,
    ),
    Text("Unlock")
  ];

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        // padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        minimumSize: MaterialStateProperty.all(Size(100, 100)),
        backgroundColor:
            MaterialStateProperty.all(Colors.blue), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) return Colors.red;
          },
          // <-- Splash color
        ));

    return Center(
        child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 25),
        child: BlocBuilder<socketBloc, socketState>(
            buildWhen: ((previous, current) {
          if (previous != current) {
            return true;
          } else {
            return false;
          }
        }), builder: (context, state) {
          return ElevatedButton(
              style: style,
              onPressed: () {
                lock();
              },
              child: Center(child: Column(children: getChild(state))));
        }),
      ),
    ]));
  }
}

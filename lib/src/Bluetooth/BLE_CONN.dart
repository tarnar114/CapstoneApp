import 'dart:async';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_bloc.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location/location.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_state.dart';

class LockButton extends StatefulWidget {
  const LockButton({required this.callback, super.key});
  final Function callback;
  @override
  State<LockButton> createState() => LockButtonState();
}

class LockButtonState extends State<LockButton> {
  List<Widget> getChild(BleState state) {
    if (state.Scanning) {
      return scanning;
    } else if (state.Connecting) {
      return Connecting;
    } else {
      return disconnected;
    }
  }

  List<Widget> disconnected = [
    Icon(
      Icons.bluetooth,
      size: 50,
    ),
    Text("connect")
  ];

  List<Widget> Connecting = [
    Icon(
      Icons.bluetooth_searching_outlined,
      size: 50,
    ),
    Text("Connecting")
  ];

  List<Widget> scanning = [
    Icon(
      Icons.wifi_2_bar_sharp,
      size: 50,
    ),
    Text("Scanning")
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
        child: BlocConsumer<BleBloc, BleState>(
            listenWhen: (previousState, state) {
              return state.Scanning != previousState.Scanning ||
                  state.Connecting != previousState.Connecting ||
                  state.Connected != previousState.Connected;
            },
            listener: (context, state) {},
            builder: (context, state) {
              return ElevatedButton(
                  style: style,
                  onPressed: () {
                    if (!state.Scanning && state.uniqueDevice == null) {
                      print("scanning");
                      context.read<BleBloc>().add(Scanning());
                    } else if (state.uniqueDevice != null) {
                      print("connecting");
                      context.read<BleBloc>().add(ConnectToDeviceEvent());
                    }
                  },
                  child: Center(child: Column(children: getChild(state))));
            }),
      ),
    ]));
  }
}

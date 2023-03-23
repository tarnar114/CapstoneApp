import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location/location.dart';

class LockButton extends StatefulWidget {
  const LockButton({required this.callback, super.key});
  final Function callback;
  @override
  State<LockButton> createState() => LockButtonState();
}

class LockButtonState extends State<LockButton> {
  //ble related variables
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late DiscoveredDevice _uniqueDevice;
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late QualifiedCharacteristic _rxChar;
  //UUIDs of phone
  final Uuid serviceUuid = Uuid.parse("181A");
  final Uuid charUuid = Uuid.parse("2A6E");
  //state changes for lock
  bool scanStarted = false; //checks if app is connecting to the lock
  bool connected = false; //checks if app is connected to the lock
  bool _foundDeviceWaitingToConnect = false;
  bool locked = false; //checks if the lock is locked or not
  Location location = Location();

  void _lockChange() {
    if (connected) {
      setState(() {
        locked = !locked;
      });
    }
  }

  void _connectToDevice() {
    _scanStream.cancel();

    Stream<ConnectionStateUpdate> _currConnectStream =
        _ble.connectToAdvertisingDevice(
            id: _uniqueDevice.id,
            withServices: [serviceUuid, charUuid],
            prescanDuration: const Duration(seconds: 5));
    _currConnectStream.listen((event) {
      switch (event.connectionState) {
        case DeviceConnectionState.connected:
          {
            _rxChar = QualifiedCharacteristic(
                serviceId: serviceUuid,
                characteristicId: charUuid,
                deviceId: event.deviceId);
            setState(() {
              _foundDeviceWaitingToConnect = false;
              connected = true;
            });
            break;
          }
        // Can add various state state updates on disconnect
        case DeviceConnectionState.disconnected:
          {
            setState(() {
              connected = false;
            });
            break;
          }
        default:
      }
    });
  }

  void startScan() async {
    bool permGranted = false;
    setState(() {
      scanStarted = true;
    });
    PermissionStatus _permissionGranted;
    print("scan started");
    _permissionGranted = await location.hasPermission();
    print(_permissionGranted.name);
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          permGranted = false;
        });
        return;
      }
    } else {
      permGranted = true;
    }

    if (permGranted) {
      _scanStream = _ble.scanForDevices(withServices: []).listen((device) {
        // if (device.name == "UBIQUE") {
        //   setState(() {
        //     _uniqueDevice = device;
        //     _foundDeviceWaitingToConnect = true;
        //   });
        // }
        if (device.name.isNotEmpty) {
          print(device.name.toString());
        }
      });
    }
  }

//UI update for state change
  List<Widget> buttonChild() {
    if (!connected) {
      return [
        Icon(
          Icons.bluetooth,
          size: 50,
        ),
        Text("connect")
      ];
    } else if (scanStarted) {
      return [
        Icon(
          Icons.bluetooth_searching,
          size: 50,
        ),
        Text("Searching")
      ];
    } else {
      if (locked) {
        return [Icon(Icons.lock, size: 50), Text("Locked")];
      } else {
        return [
          Icon(
            Icons.lock_open,
            size: 50,
          ),
          const Text("Unlocked")
        ];
      }
    }
  }

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
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                if (!_foundDeviceWaitingToConnect) {
                  startScan();
                } else if (_foundDeviceWaitingToConnect) {
                  _connectToDevice();
                } else if (connected) {
                  _lockChange();
                }
              },
              child: Center(
                child: Column(children: buttonChild()),
              ),
            ),
          )
        ],
      ),
    );
  }
}

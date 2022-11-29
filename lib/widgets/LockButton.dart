import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class LockButton extends StatefulWidget {
  const LockButton({required this.callback, super.key});
  final Function callback;
  @override
  State<LockButton> createState() => LockButtonState();
}

class LockButtonState extends State<LockButton> {
  bool locked = true;
  bool connected = false;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void _lockChange() {
    // setState(() {
    //   locked = !locked;
    // });
    flutterBlue.startScan(timeout: Duration(seconds: 15));
    bool foundDevice = false;
    ScanResult foundResult;
// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      if (foundDevice == false) {
        for (ScanResult r in results) {
          if (r.device.name.isNotEmpty) {
            print(r.device.toString());
          }
          if (r.device.name == "LightBlue") {
            flutterBlue.stopScan();

            connect(r);
          }
        }
      }
    });
  }

  void connect(ScanResult foundDevice) async {
    print("-------------------------------");
    await foundDevice.device.connect();
  }

  List<Widget> buttonChild() {
    if (!connected) {
      return [
        Icon(
          Icons.wifi,
          size: 50,
        ),
        Text("connect")
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
                _lockChange();
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

import 'package:flutter/material.dart';

class LockButton extends StatefulWidget {
  const LockButton({super.key});

  @override
  State<LockButton> createState() => LockButtonState();
}

class LockButtonState extends State<LockButton> {
  bool locked = true;
  void _lockChange() {
    setState(() {
      locked = !locked;
    });
  }

  List<Widget> buttonChild() {
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
              onPressed: _lockChange,
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

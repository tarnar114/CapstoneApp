import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard(
      {
      // required this.time,
      super.key});
  // final String time;
  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Expanded(
              child: ListTile(
            leading: Icon(Icons.alarm),
            title: Text(
              '9:15 a.m.',
              style: TextStyle(fontSize: 23),
            ),
            subtitle: Text(
              'S M T W T F S',
              style: TextStyle(fontSize: 12),
            ),
          )),
          Container(
              width: 120,
              child: const Align(
                alignment: Alignment.center,
                child: AlarmSwitch(),
              ))
        ],
      ),
    );
  }
}

class AlarmSwitch extends StatefulWidget {
  const AlarmSwitch({super.key});

  @override
  State<AlarmSwitch> createState() => AlarmState();
}

class AlarmState extends State<AlarmSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blue,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({required this.time, required this.Days, super.key});
  final String time;
  final List<String> Days;
  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool light = true;
  List<TextSpan> textformat() {
    List<TextSpan> alarmDays = List.filled(7, TextSpan(text: ""));
    bool bold = false;
    List<String> weekdays = ["S", "M", "T", "W", "T", "F", "S"];
    for (var i = 0; i < widget.Days.length; i++) {
      if (widget.Days[i] == "T") {
        bold = true;
      } else if (widget.Days[i] == "F") {
        bold = false;
      }

      if (bold) {
        alarmDays[i] = TextSpan(
            text: weekdays[i],
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue));
      } else {
        alarmDays[i] = TextSpan(
            text: weekdays[i],
            style: TextStyle(fontSize: 14, color: Colors.grey));
      }
    }
    return alarmDays;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: ListTile(
            leading: Icon(Icons.alarm),
            title: Text(
              widget.time,
              style: TextStyle(fontSize: 23),
            ),
            subtitle: Text.rich(
              TextSpan(children: textformat()),
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

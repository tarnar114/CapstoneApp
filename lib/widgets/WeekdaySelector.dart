import 'package:flutter/material.dart';

const List<Widget> weekDays = <Widget>[
  Text('S'),
  Text('M'),
  Text('T'),
  Text('W'),
  Text('T'),
  Text('F'),
  Text('S'),
];

class WeekDaySelector extends StatefulWidget {
  final Function callback;
  const WeekDaySelector({required this.callback, super.key});

  @override
  State<WeekDaySelector> createState() => _WeekDaySelectorState();
}

class _WeekDaySelectorState extends State<WeekDaySelector> {
  final List<bool> _selectedDays = List.filled(7, false);

  bool vertical = false;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        direction: vertical ? Axis.vertical : Axis.horizontal,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onPressed: (int index) {
          setState(() {
            _selectedDays[index] = !_selectedDays[index];
          });
          widget.callback(_selectedDays);
        },
        children: weekDays,
        isSelected: _selectedDays);
  }
}

import 'package:capstone_app/widgets/WeekdaySelector.dart';
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

/// The screen of the second page.

class AddAlert extends StatefulWidget {
  const AddAlert({super.key});

  @override
  State<AddAlert> createState() => _AddAlertState();
}

class _AddAlertState extends State<AddAlert> {
  DateTime _dateTime = DateTime.now();
  List<bool> selectedDays = List.filled(7, false);
  void _saveState(DateTime time, List<bool> weekdays) {
    String HourDay = DateFormat.jm().format(time);
    print(HourDay);
    List<String> bools = List.filled(7, "F");
    for (var i = 0; i < weekdays.length; i++) {
      if (weekdays[i] == true) {
        bools[i] = "T";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustAppBar(),
        drawer: CustDrawer(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimePickerSpinner(
              is24HourMode: false,
              onTimeChange: (time) {
                setState(() {
                  _dateTime = time;
                });
              },
            ),
            const SizedBox(height: 20),
            WeekDaySelector(
              callback: _callback,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => _saveState(_dateTime, selectedDays),
                child: Text("save"))
          ],
        )));
  }

  void _callback(List<bool> weekDays) {
    setState(() {
      selectedDays = weekDays;
    });
  }
}

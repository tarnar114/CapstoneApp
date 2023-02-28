import 'package:capstone_app/data/AlertStorage.dart';
import 'package:capstone_app/widgets/WeekdaySelector.dart';
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'package:go_router/go_router.dart';

/// The screen of the second page.

class AddAlert extends StatefulWidget {
  const AddAlert({super.key, required this.storage});
  final AlertStorage storage;
  @override
  State<AddAlert> createState() => _AddAlertState();
}

class _AddAlertState extends State<AddAlert> {
  DateTime _dateTime = DateTime.now();
  List<bool> selectedDays = List.filled(7, false);

  List format(DateTime time, List<bool> weekdays) {
    String HourDay = DateFormat.jm().format(time);
    print(HourDay);
    List<String> bools = List.filled(7, "F");
    for (var i = 0; i < weekdays.length; i++) {
      if (weekdays[i] == true) {
        bools[i] = "T";
      }
    }
    var stringList = bools.join(" ");
    print(stringList);
    return [HourDay, bools];
  }

  Future<void> saveAlert(DateTime time, List<bool> weekdays) {
    List Alert = format(time, weekdays);
    String alertTime = Alert[0];
    List<String> weekdayStrings = Alert[1];
    return widget.storage.writeAlert(alertTime, weekdayStrings);
  }

  void readAlerts() async {
    String hello = await widget.storage.readAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustAppBar(
          title: "Add Alert",
        ),
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
                onPressed: () {
                  saveAlert(_dateTime, selectedDays);
                  context.go('/alerts');
                },
                child: Text("save")),
          ],
        )));
  }

  void _callback(List<bool> weekDays) {
    setState(() {
      selectedDays = weekDays;
    });
  }
}

import 'package:capstone_app/data/AlertStorage.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_bloc.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_event.dart';
import 'package:capstone_app/widgets/WeekdaySelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'dart:convert' show utf8;

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
  String futureTime = "";
  List format(DateTime time, List<bool> weekdays) {
    String HourDay = DateFormat.jm().format(time);
    setState(() {
      futureTime = HourDay;
    });
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
    print(time.toString());
    List Alert = format(time, weekdays);
    String alertTime = Alert[0];
    print(alertTime);
    List<String> weekdayStrings = Alert[1];
    return widget.storage.writeAlert(alertTime, weekdayStrings);
  }

  void readAlerts() async {
    String hello = await widget.storage.readAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              DateTime currTime = DateTime.now();
              String currTimeString = DateFormat.jm().format(currTime);
              var currTimeEncoded = utf8.encode(currTimeString);
              var futureTimeEncoded = utf8.encode(futureTime);
              context
                  .read<BleBloc>()
                  .add(WriteCharacteristicEvent(currTimeEncoded));
              context
                  .read<BleBloc>()
                  .add(WriteCharacteristicEvent(futureTimeEncoded));
              context.go('/alerts');
            },
            child: Text("save")),
      ],
    ));
  }

  void _callback(List<bool> weekDays) {
    setState(() {
      selectedDays = weekDays;
    });
  }
}

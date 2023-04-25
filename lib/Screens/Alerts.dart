import 'dart:convert';

import 'package:capstone_app/data/Alert.dart';
import 'package:capstone_app/widgets/AlarmCard.dart';
import 'package:flutter/material.dart';
import '../widgets/AddAlarm.dart';
import 'package:capstone_app/data/AlertStorage.dart';

/// The screen of the second page.
class Alert extends StatefulWidget {
  const Alert({super.key, required this.storage});
  final AlertStorage storage;

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  late List<String> alerts;
  bool loading = true;
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  Future<void> load() async {
    String data = await widget.storage.readAlerts();
    const splitter = LineSplitter();

    setState(() {
      alerts = splitter.convert(data);
      loading = false;
    });
    // return data;
  }

  Future readAlerts() async {
    for (var i = 0; i < alerts.length; i++) {
      Map<String, dynamic> map = jsonDecode(alerts[i]);

      print('$i: ' + map.toString());
    }
    // print(alerts);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ));
    } else {
      return Column(children: [
        titleSection,
        SizedBox(height: 10),
        Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> map = jsonDecode(alerts[index]);
                  var time = AlertClass.fromJson(map);
                  List<String> days = time.alertDays.cast<String>();
                  return AlarmCard(time: time.time, Days: days);
                },
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: alerts.length)),
      ]);
    }
  }
}

Widget titleSection = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Lock Sessions',
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
        AddAlarm()
      ],
    ));

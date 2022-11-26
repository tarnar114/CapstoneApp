import 'package:capstone_app/widgets/AlarmCard.dart';
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import '../widgets/AddAlarm.dart';

/// The screen of the second page.

class Alerts extends StatelessWidget {
  /// Creates a [Page2Screen].
  const Alerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustAppBar(),
      drawer: CustDrawer(),
      body: Column(
        children: [titleSection, AlarmCard()],
      ));
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

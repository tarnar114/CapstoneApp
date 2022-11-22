import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        children: [
          titleSection,
        ],
      ));
}

Widget titleSection = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alerts',
                style: TextStyle(
                  color: Colors.grey[500],
                )),
            AddAlarm()
          ],
        )
      ],
    ));

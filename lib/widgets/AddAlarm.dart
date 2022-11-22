import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddAlarm> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
        padding: MaterialStateProperty.all(EdgeInsets.all(5)));
    return Container(
        child: ElevatedButton(
            onPressed: () {},
            style: style,
            child: Center(child: Icon(Icons.add))));
  }
}

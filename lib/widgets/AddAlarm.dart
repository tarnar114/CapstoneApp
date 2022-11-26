import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(EdgeInsets.all(5)));
    return Container(
        child: ElevatedButton(
            onPressed: () {
              context.go('/add_alert');
            },
            style: style,
            child: Center(
                child: Icon(
              Icons.add,
              color: Colors.black,
            ))));
  }
}

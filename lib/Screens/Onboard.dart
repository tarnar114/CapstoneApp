import 'package:capstone_app/widgets/CustAppBar.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [Text('data')]),
      ),
    );
  }
}

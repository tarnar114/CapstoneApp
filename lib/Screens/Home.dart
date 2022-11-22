/// The screen of the first page.
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import '../widgets/LockButton.dart';

class Home extends StatelessWidget {
  /// Creates a [Page1Screen].
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustAppBar(), drawer: CustDrawer(), body: const LockButton());
}

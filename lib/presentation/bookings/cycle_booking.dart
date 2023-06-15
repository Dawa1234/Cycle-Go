import 'package:cyclego/constants/utils/backButton.dart';
import 'package:flutter/material.dart';

class CycleBookingScreen extends StatelessWidget {
  const CycleBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
      ),
      body: const Center(
        child: Text("Book Cycle in this screen."),
      ),
    );
  }
}

import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/buttons.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:flutter/material.dart';

class MoreCycleScreen extends StatelessWidget {
  const MoreCycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: const Color.fromARGB(255, 39, 139, 233),
        actions: const [ProfileButton()],
      ),
      body: Column(
        children: [
          AppBarContainer(
            height: 95,
            topText: Row(
              children: const [
                Text(
                  "Hello, ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Anonymous",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            bottomText: const Text(
              "Choose Your Bike",
              style: TextStyle(
                  fontFamily: "",
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

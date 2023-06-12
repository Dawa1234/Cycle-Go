import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';

class CycleDescriptionScreen extends StatelessWidget {
  const CycleDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
        ),
        body: Column(
          children: [
            Container(
              // height: phoneHeight(context),
              height: 370,
              width: phoneWeight(context),
              decoration: _boxDecoration(context),
            ),
            Expanded(
                child: SizedBox(
              // color: Colors.grey.shade600,
              width: phoneWeight(context),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CYCLE NAME',
                      style: TextStyle(
                          wordSpacing: 2,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.green),
                    ),
                    verticalGap5,
                    const Divider(
                      thickness: 1,
                    ),
                    verticalGap5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "Primary Color",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Green"),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "75 km/h",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Speed"),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "4.8",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Rating"),
                          ],
                        ),
                        horizontalGap5
                      ],
                    ),
                    verticalGap5,
                    const Divider(
                      thickness: 1,
                    ),
                    verticalGap5,
                    const Text(
                        "This section is for the description of the cycle shown in the above image."),
                    const Expanded(child: SizedBox()),
                    FullButton(
                      onTap: () {},
                      padding: const EdgeInsets.all(10),
                      text: "SET TIME",
                    )
                  ],
                ),
              ),
            )),
          ],
        ));
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              offset: const Offset(0, 6),
              color: Theme.of(context).highlightColor)
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ));
  }
}

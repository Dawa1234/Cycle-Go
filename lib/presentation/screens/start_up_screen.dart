import 'package:cyclego/constants/ui/light_theme.data.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: phoneHeight(context),
        width: phoneWeight(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/images/map.jpg"))),
        child: Column(
          children: [
            verticalGap50,
            verticalGap30,
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text(
                      "2022 - 2023",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: AutofillHints.addressCityAndState,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.fromLTRB(40, 0, 130, 0),
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        const Text(
                          "All Your Needs In Your Hands",
                          style: TextStyle(
                              fontFamily: AutofillHints.addressCityAndState,
                              fontSize: 50,
                              color: Colors.white),
                        ),
                        Positioned(
                            bottom: 55,
                            right: 40,
                            child: SizedBox(
                              height: 60,
                              child: Image.asset("assets/images/cycle.png"),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Container(
                height: 55,
                width: phoneWeight(context),
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                    color: primaryColor,
                    splashColor: Colors.transparent,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.homeScreen),
                    child: Text(
                      "GET STARTED",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

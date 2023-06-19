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
        width: phoneWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/images/map.jpg"))),
        child: Column(
          children: [
            verticalGap50,
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
                              child:
                                  Image.asset("assets/images/cycle-icon.png"),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FullButton(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.homeScreen),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              text: "GET STARTED",
            )
          ],
        ),
      ),
    );
  }
}

class FullButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double? fontSize;
  final double? buttonHeight;
  final bool? showIcon;
  final EdgeInsetsGeometry padding;
  final double? letterSpacing;

  const FullButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.padding,
    this.fontSize,
    this.buttonHeight,
    this.letterSpacing,
    this.showIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: buttonHeight ?? 55,
        width: phoneWidth(context),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: MaterialButton(
            color: const Color.fromARGB(255, 39, 139, 233),
            splashColor: Colors.transparent,
            textColor: Colors.white,
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      letterSpacing: letterSpacing ?? 1,
                      fontSize: fontSize ?? 25),
                ),
                showIcon!
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.open_in_new,
                          size: 20,
                        ),
                      )
                    : const SizedBox(),
              ],
            )),
      ),
    );
  }
}

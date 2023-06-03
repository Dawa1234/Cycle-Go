import 'package:flutter/material.dart';

const SizedBox horizontalGap10 = SizedBox(
  width: 10,
);
const SizedBox horizontalGap20 = SizedBox(
  width: 20,
);
const SizedBox horizontalGap30 = SizedBox(
  width: 30,
);
const SizedBox horizontalGap50 = SizedBox(
  width: 50,
);

const SizedBox verticalGap10 = SizedBox(
  height: 10,
);
const SizedBox verticalGap20 = SizedBox(
  height: 20,
);
const SizedBox verticalGap30 = SizedBox(
  height: 30,
);
const SizedBox verticalGap50 = SizedBox(
  height: 50,
);

double phoneHeight(context) {
  return MediaQuery.of(context).size.height;
}

double phoneWeight(context) {
  return MediaQuery.of(context).size.width;
}

class AppTheme {
  static SizedBox appIcon(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: const Color.fromARGB(255, 35, 53, 71),
        ),
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/icon.jpg"),
        ),
      ),
    );
  }
}

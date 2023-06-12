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

  static Widget cycleContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.black26,
            )
          ]),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/cycle.png"))),
            width: double.infinity,
            height: 80,
          ),
          Text(
            'CYCLE NAME',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey.shade800,
                color: Colors.transparent,
                shadows: [
                  Shadow(
                      color: Colors.grey.shade800, offset: const Offset(0, -6))
                ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 7,
              ),
              Text(
                "Type: ",
                style: TextStyle(fontSize: 11),
              ),
              Text(
                "Cycle Type",
                style: TextStyle(fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
  }
}

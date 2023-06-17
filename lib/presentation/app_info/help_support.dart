import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> answer_questions = const [
    {
      "question": "Does it cost me anything to list a ride?",
      "answer":
          "This is to make clear, that listing your ride (cycle) take charge! However, it only gets paid as per hour, the price listed on the cycle. When your payment request is approved, cycle you booked for is added on the booked screen."
    },
    {
      "question": "What if I can only rent my ride out certain days?",
      "answer":
          "No problem! We have an availability calendar where you can mark off the times your ride is completely unavailable, or when you just can't do a drop-off. If your ride is listed as available, Renters can request and contact you whenever they want to reserve your ride. If a request is not convenient for you, you can always decline a request without regret."
    },
    {
      "question": "Are your panniers water proof?",
      "answer":
          "Totally! Cycling Rentals offers the best bicycle pannier rental in the business: 100% water proof "
    },
    {
      "question": "What does your bicycle rental include?",
      "answer":
          "Each and every Cycling Rentals bike hire is delivered with a Water bottle (yours to keep), Mini-tool, Spare tube, Tire Levers, Pump and Bike Lock. We also include easy to read instructions on how to unpack and operate your rental bike and accessories."
    },
    {
      "question":
          "What if someone gets injured or my property is damaged while renting my ride?",
      "answer":
          "Before confirming any reservation, the Renter has to sign our Spinlister Rental Agreement. This agreement offers you protection against injury to the Renter or damage to your property - as the Lister, you are never responsible if the Renter gets injured on a ride. At the same time, you'd be doing us all a solid by making sure your ride is always tuned up and ready to go when you pass it off."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Padding(
            padding: const EdgeInsets.only(top: 21.0),
            child: AppTheme.appIcon(80),
          ),
          toolbarHeight: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                "Frequent Asked Questions",
                style: TextStyle(
                    fontFamily: "", fontSize: 40, fontWeight: FontWeight.bold),
              )),
              Wrap(
                children: const [
                  Text(
                    "Quick answers to questions you may have. Can't find what you are looking for? Check out our",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "full documentation",
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        color: Colors.transparent,
                        shadows: [Shadow(offset: Offset(0, -2))]),
                  ),
                  Text(
                    ".",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              verticalGap20,
              FullButton(
                  onTap: () {},
                  text: "Documentation",
                  buttonHeight: 45,
                  fontSize: 18,
                  showIcon: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20)),
              verticalGap30,
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior()
                      .copyWith(scrollbars: true, overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: answer_questions
                          .map((data) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['question']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(data['answer']!),
                                  verticalGap20,
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

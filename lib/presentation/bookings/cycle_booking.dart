import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyclego/constants/ui/light_theme.data.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/logic/transaction/transaction_bloc.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CycleBookingScreen extends StatefulWidget {
  final CycleDetail cycleDetail;
  const CycleBookingScreen({Key? key, required this.cycleDetail})
      : super(key: key);

  @override
  State<CycleBookingScreen> createState() => _CycleBookingScreenState();
}

class _CycleBookingScreenState extends State<CycleBookingScreen> {
  int _selected = 0;
  late CycleDetail cycleDetail;
  String selectedUnit = "";
  String selectedHour = "";
  String selectedDay = "";
  String selectedWeek = "";
  double totalAmount = 1;
  double discountedAmount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cycleDetail = widget.cycleDetail;
    selectedUnit = units[0];
    selectedHour = hours[0];
    selectedDay = day[0];
    selectedWeek = week[0];
  }

  List<String> units = [
    "Hour",
    "Day(s)",
    "Week(s)",
  ];
  List<String> hours = [
    "Half",
    "1",
    "1 & half",
    "2",
    "2 & half",
    "3",
    "3 & half",
    "4",
    "4 & half",
    "5",
    "5 & half",
    "6",
    "6 & half",
    "7",
    "7 & half",
    "8",
    "8 & half",
    "9",
    "9 & half",
    "10",
    "10 & half",
    "11",
    "11 & half",
    "12",
    "12 & half",
  ];

  List<String> day = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];
  List<String> week = [
    "1",
    "2",
    "3",
    "4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
      ),
      body: Column(
        children: [
          Container(
            height: phoneHeight(context) * .45,
            width: phoneWidth(context),
            decoration: _boxDecoration(context),
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                      items: cycleDetail.image!
                          .map(
                            (image) => Container(
                              margin: const EdgeInsets.all(10),
                              width: phoneWidth(context),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(image))),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        aspectRatio: 11 / 9,
                        onPageChanged: (index, reason) {
                          setState(() => _selected = index);
                        },
                      )),
                ),
                SizedBox(
                  height: 25,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              width: 5.0,
                              height: 5.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == _selected
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withOpacity(.2),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                verticalGap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cycleDetail.name!,
                      style: const TextStyle(
                          wordSpacing: 2,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.green),
                    ),
                    Text(
                      "Rs.${cycleDetail.price!} /hr",
                      style: const TextStyle(
                        wordSpacing: 2,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                verticalGap10,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).highlightColor,
                                  blurRadius: 3,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Center(
                              child: Text(
                                selectedUnit == units[0]
                                    ? selectedHour
                                    : selectedUnit == units[1]
                                        ? selectedDay
                                        : selectedWeek,
                                style: const TextStyle(color: primaryColor),
                              ),
                            )),
                            InkWell(
                                onTap: () async {
                                  await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: selectedUnit == units[0]
                                              ? hours.map((hour) {
                                                  return ListTile(
                                                    onTap: () {
                                                      setState(() =>
                                                          selectedHour = hour);
                                                      Navigator.pop(context);
                                                    },
                                                    title: Center(
                                                      child: Text(
                                                        hour,
                                                        style: const TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  );
                                                }).toList()
                                              : selectedUnit == units[1]
                                                  ? day.map((day) {
                                                      return ListTile(
                                                        onTap: () {
                                                          setState(() =>
                                                              selectedDay =
                                                                  day);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title: Center(
                                                          child: Text(
                                                            day,
                                                            style: const TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList()
                                                  : week.map((week) {
                                                      return ListTile(
                                                        onTap: () {
                                                          setState(() =>
                                                              selectedWeek =
                                                                  week);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title: Center(
                                                          child: Text(
                                                            week,
                                                            style: const TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_drop_down_circle_sharp))
                          ],
                        ),
                      ),
                    ),
                    horizontalGap20,
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).highlightColor,
                                blurRadius: 3,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(child: Center(child: Text(selectedUnit))),
                          InkWell(
                              onTap: () async {
                                await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: units.map((unit) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() => selectedUnit = unit);
                                            Navigator.pop(context);
                                          },
                                          title: Center(
                                            child: Text(
                                              unit,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                  Icons.arrow_drop_down_circle_sharp))
                        ],
                      ),
                    ),
                  ],
                ),
                verticalGap10,
                const Divider(
                  thickness: 1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(alignment: WrapAlignment.start, children: const [
                    Text("Note: Price is discounted by "),
                    Text(
                      "5%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(" for per day and "),
                    Text(
                      "10%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(" for per week"),
                  ]),
                ),
              ],
            ),
          )),
          FullButton(
              onTap: _handleBooking,
              text: "Rent Bike".toUpperCase(),
              padding: const EdgeInsets.all(24)),
        ],
      ),
    );
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

  _handleBooking() {
    BlocProvider.of<TransactionBloc>(context).add(StartTxnEvent(
        cycleId: cycleDetail.id!,
        amount: _getTotalAmount().round(),
        context: context));
  }

  double _getTotalAmount() {
    // hour
    if (selectedUnit == units[0]) {
      if (hours.indexOf(selectedHour) == 0) {
        return 0.5 * int.parse(cycleDetail.price!);
      }
      if (hours.indexOf(selectedHour) % 2 == 0) {
        String seperatedAmount = selectedHour.split(' ')[0] + ".5";
        totalAmount =
            double.parse(seperatedAmount) * int.parse(cycleDetail.price!);
        return totalAmount;
      } else {
        totalAmount =
            double.parse(selectedHour) * int.parse(cycleDetail.price!);
        return totalAmount;
      }
    }
    // day
    if (selectedUnit == units[1]) {
      double totalHours = double.parse(selectedDay) * 24;
      totalAmount = totalHours * int.parse(cycleDetail.price!);
      discountedAmount = (totalAmount * 0.05);
      return totalAmount - discountedAmount;
    }
    // week
    if (selectedUnit == units[2]) {
      double totalHours = double.parse(selectedWeek) * 168;
      totalAmount = totalHours * int.parse(cycleDetail.price!);
      discountedAmount = (totalAmount * 0.1);
      return totalAmount - discountedAmount;
    }
    return -1;
  }
}

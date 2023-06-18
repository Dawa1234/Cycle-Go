import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';

class AllCycleScreen extends StatefulWidget {
  const AllCycleScreen({Key? key}) : super(key: key);

  @override
  State<AllCycleScreen> createState() => _AllCycleScreenState();
}

class _AllCycleScreenState extends State<AllCycleScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _cycleTypes = [
    {
      "cycle": "All",
      "index": 0,
    },
    {
      "cycle": "City",
      "index": 1,
    },
    {
      "cycle": "Tour",
      "index": 2,
    },
    {
      "cycle": "Hybrid",
      "index": 3,
    },
    {
      "cycle": "Road",
      "index": 4,
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 80,
          width: phoneWidth(context),
          child: TabBar(
              splashFactory: NoSplash.splashFactory,
              indicatorColor: Colors.transparent,
              isScrollable: true,
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (value) => setState(() => _currentIndex = value),
              physics: const BouncingScrollPhysics(),
              tabs: _cycleTypes
                  .map(
                    (cyclesType) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _currentIndex == cyclesType['index']
                              ? Colors.green
                              : const Color.fromARGB(255, 239, 239, 239),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: .5,
                                offset: const Offset(0, 3),
                                color: Colors.grey.shade500)
                          ]),
                      height: 110,
                      width: 70,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(cyclesType['cycle']),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
            child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / .87),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: AppTheme.cycleContainer(
                context,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.cycleDescription),
              ),
            );
          },
        ))
      ],
    ));
  }
}

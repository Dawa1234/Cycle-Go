import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/empty_data_message.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCycleScreen extends StatefulWidget {
  const AllCycleScreen({Key? key}) : super(key: key);

  @override
  State<AllCycleScreen> createState() => _AllCycleScreenState();
}

class _AllCycleScreenState extends State<AllCycleScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  late CycleBloc _cycleBloc;
  List<CycleModel> allCycles = [];
  final List<Map<String, dynamic>> _cycleTypes = [
    {
      "cycle": "All",
      "index": 0,
    },
    {
      "cycle": "Available",
      "index": 1,
    },
    {
      "cycle": "City",
      "index": 2,
    },
    {
      "cycle": "Tour",
      "index": 3,
    },
    {
      "cycle": "Hybrid",
      "index": 4,
    },
    {
      "cycle": "Road",
      "index": 5,
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _cycleBloc = BlocProvider.of<CycleBloc>(context)..add(InitialCycleEvent());
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
              onTap: (value) {
                setState(() => _currentIndex = value);
                if (_currentIndex == 0) {
                  _cycleBloc.add(InitialCycleEvent());
                  return;
                }
                if (_currentIndex == 1) {
                  _cycleBloc.add(FilterCycleEvent(
                      allCycles: allCycles,
                      cycleType: _cycleTypes[_currentIndex]['cycle']));
                  return;
                }
                _cycleBloc.add(FilterCycleEvent(
                    allCycles: allCycles,
                    cycleType: _cycleTypes[_currentIndex]['cycle']));
              },
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
            child: BlocBuilder<CycleBloc, CycleState>(
          bloc: _cycleBloc,
          builder: (context, state) {
            if (state is CycleLoading) {
              return Center(
                child: LoadingBar(),
              );
            }
            if (state is FilteredCycle) {
              return state.allCycles.isEmpty
                  ? EmptyDataMessage.emptyDataMessage(
                      message: 'No any bicycle related to the query.')
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / .87),
                      itemCount: state.allCycles.length,
                      itemBuilder: (context, index) {
                        CycleModel cycle = state.allCycles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: AppTheme.cycleContainer(
                            context,
                            cycle: cycle,
                            onTap: () => Navigator.pushNamed(
                                context, Routes.cycleDescription,
                                arguments: {'cycleId': cycle.id}),
                          ),
                        );
                      },
                    );
            }
            if (state is ErrorCycle) {
              return EmptyDataMessage.emptyDataMessage(message: state.error);
            }
            if (state is CycleFetched) {
              allCycles = state.allCycles;
              return RefreshIndicator(
                displacement: 10,
                onRefresh: () async {
                  BlocProvider.of<CycleBloc>(context).add(InitialCycleEvent());
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / .87),
                  itemCount: allCycles.length,
                  itemBuilder: (context, index) {
                    CycleModel cycle = allCycles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: AppTheme.cycleContainer(
                        context,
                        cycle: cycle,
                        onTap: () => Navigator.pushNamed(
                            context, Routes.cycleDescription,
                            arguments: {'cycleId': cycle.id}),
                      ),
                    );
                  },
                ),
              );
            }
            return EmptyDataMessage.emptyDataMessage(message: 'No data');
          },
        ))
      ],
    ));
  }
}

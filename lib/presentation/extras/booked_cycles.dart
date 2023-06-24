import 'package:cyclego/constants/utils/empty_data_message.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/logic/booked_cycle/booked_cycle_cubit.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedCycles extends StatefulWidget {
  const BookedCycles({Key? key}) : super(key: key);

  @override
  State<BookedCycles> createState() => _BookedCyclesState();
}

class _BookedCyclesState extends State<BookedCycles> {
  late BookedCycleCubit _bookedCycleCubit;

  @override
  void initState() {
    super.initState();
    _bookedCycleCubit = BlocProvider.of<BookedCycleCubit>(context)..init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookedCycleCubit, BookedCycleState>(
        builder: (context, state) {
          if (state is BookedCycleFetching) {
            return Center(
              child: LoadingBar(),
            );
          }
          if (state is BookedCycleFetched) {
            return state.bookedCycles.isEmpty
                ? EmptyDataMessage.emptyDataMessage(
                    message: 'No any bicycles oin your booking list.')
                : RefreshIndicator(
                    displacement: 10,
                    onRefresh: () async {
                      BlocProvider.of<BookedCycleCubit>(context).init();
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / .87),
                      itemCount: state.bookedCycles.length,
                      itemBuilder: (context, index) {
                        CycleModel cycle = state.bookedCycles[index];
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
          return EmptyDataMessage.emptyDataMessage(message: "No data");
        },
      ),
    );
  }
}

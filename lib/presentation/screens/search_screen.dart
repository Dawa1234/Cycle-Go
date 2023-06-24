import 'package:cyclego/constants/enums/enum.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/logic/booked_cycle/booked_cycle_cubit.dart';
import 'package:cyclego/logic/favorites/favorites_cubit.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final CurrentScreen searchBy;
  const SearchScreen({Key? key, required this.searchBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchBy == CurrentScreen.fav
        ? const _SearchFavourites()
        : const _SearchBookedCycles();
  }
}

class _SearchFavourites extends StatefulWidget {
  const _SearchFavourites({Key? key}) : super(key: key);

  @override
  State<_SearchFavourites> createState() => _SearchFavouritesState();
}

class _SearchFavouritesState extends State<_SearchFavourites> {
  final _favController = TextEditingController();
  late FavoritesCubit _favoritesCubit;
  List<CycleModel> allFavCycles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesCubit = FavoritesCubit()..fectchFavCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: const AppBackButton(),
        title: TextFormField(
          style: const TextStyle(fontFamily: 'Tondo', color: Colors.black),
          controller: _favController,
          onChanged: (value) {
            if (value.isEmpty) {
              _favoritesCubit.fetchedFavCycle(favCycles: allFavCycles);
              return;
            }
            _favoritesCubit.filterFavCycle(
                allFavCycles: allFavCycles, cycleName: value);
          },
          decoration: InputDecoration(
              hintText: "Serach Favorite cycle by name.",
              filled: true,
              fillColor: const Color.fromRGBO(0, 0, 0, 470),
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              errorBorder: inputBorder,
              disabledBorder: inputBorder,
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: InkWell(
                onTap: () {
                  _favController.clear();
                  _favoritesCubit.fetchedFavCycle(favCycles: allFavCycles);
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: Colors.blue.shade900,
                ),
              )),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: _favoritesCubit,
        builder: (context, state) {
          if (state is FavoritesFetching) {
            return Center(
              child: LoadingBar(),
            );
          }
          if (state is FavoritesFetched) {
            allFavCycles = state.favCycles;
            return allFavCycles.isEmpty
                ? const Center(
                    child: Text("No any favourites."),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / .87),
                    itemCount: allFavCycles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: AppTheme.cycleContainer(
                          context,
                          cycle: allFavCycles[index],
                          onTap: () => Navigator.pushNamed(
                              context, Routes.cycleDescription,
                              arguments: {'cycleId': allFavCycles[index].id}),
                        ),
                      );
                    },
                  );
          }
          if (state is FilterFavorites) {
            List<CycleModel> filteredFavCycles = state.favCycles;
            return filteredFavCycles.isEmpty
                ? const Center(
                    child: Text("No any favourites."),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / .87),
                    itemCount: filteredFavCycles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: AppTheme.cycleContainer(
                          context,
                          cycle: filteredFavCycles[index],
                          onTap: () => Navigator.pushNamed(
                              context, Routes.cycleDescription, arguments: {
                            'cycleId': filteredFavCycles[index].id
                          }),
                        ),
                      );
                    },
                  );
          }
          return const Center(
            child: Text("No Any Favorite cycles."),
          );
        },
      ),
    );
  }

  get inputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 0, color: Colors.transparent));
}

class _SearchBookedCycles extends StatefulWidget {
  const _SearchBookedCycles({Key? key}) : super(key: key);

  @override
  State<_SearchBookedCycles> createState() => _SearchBookedCyclesState();
}

class _SearchBookedCyclesState extends State<_SearchBookedCycles> {
  final _bookController = TextEditingController();
  late BookedCycleCubit _bookedCycleCubit;
  List<CycleModel> allBookedCycles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookedCycleCubit = BookedCycleCubit()..init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: const AppBackButton(),
        title: TextFormField(
          style: const TextStyle(fontFamily: 'Tondo', color: Colors.black),
          controller: _bookController,
          onChanged: (value) {
            if (value.isEmpty) {
              _bookedCycleCubit.fetchedBookedCycle(
                  bookedCycles: allBookedCycles);
              return;
            }
            _bookedCycleCubit.filterBookedCycle(
                bookedCycles: allBookedCycles, cycleName: value);
          },
          decoration: InputDecoration(
              hintText: "Serach Booked cycle by name.",
              filled: true,
              fillColor: const Color.fromRGBO(0, 0, 0, 470),
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              errorBorder: inputBorder,
              disabledBorder: inputBorder,
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: InkWell(
                onTap: () {
                  _bookController.clear();
                  _bookedCycleCubit.fetchedBookedCycle(
                      bookedCycles: allBookedCycles);
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: Colors.blue.shade900,
                ),
              )),
        ),
      ),
      body: BlocBuilder<BookedCycleCubit, BookedCycleState>(
        bloc: _bookedCycleCubit,
        builder: (context, state) {
          if (state is BookedCycleFetching) {
            return Center(
              child: LoadingBar(),
            );
          }
          if (state is BookedCycleFetched) {
            allBookedCycles = state.bookedCycles;
            return allBookedCycles.isEmpty
                ? const Center(
                    child: Text("No any favourites."),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / .87),
                    itemCount: allBookedCycles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: AppTheme.cycleContainer(
                          context,
                          cycle: allBookedCycles[index],
                          onTap: () => Navigator.pushNamed(
                              context, Routes.cycleDescription, arguments: {
                            'cycleId': allBookedCycles[index].id
                          }),
                        ),
                      );
                    },
                  );
          }
          if (state is FilteredBookedCycle) {
            List<CycleModel> filteredBookedCycles = state.bookedCycles;
            return filteredBookedCycles.isEmpty
                ? const Center(
                    child: Text("No any Booked Cycles."),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / .87),
                    itemCount: filteredBookedCycles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: AppTheme.cycleContainer(
                          context,
                          cycle: filteredBookedCycles[index],
                          onTap: () => Navigator.pushNamed(
                              context, Routes.cycleDescription, arguments: {
                            'cycleId': filteredBookedCycles[index].id
                          }),
                        ),
                      );
                    },
                  );
          }
          return const Center(
            child: Text("No Any Favorite cycles."),
          );
        },
      ),
    );
  }

  get inputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 0, color: Colors.transparent));
}

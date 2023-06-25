import 'package:cyclego/constants/utils/empty_data_message.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/favorites/favorites_cubit.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesCubit _favoritesCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesCubit = getIt.get<FavoritesCubit>()..fectchFavCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: _favoritesCubit,
        builder: (context, state) {
          if (state is FavoritesFetching) {
            return Center(
              child: LoadingBar(),
            );
          }
          if (state is FavoritesFetched) {
            List<CycleModel> favCycles = state.favCycles;
            return favCycles.isEmpty
                ? EmptyDataMessage.emptyDataMessage(
                    message: 'Add some bicycle in your favorite list.')
                : RefreshIndicator(
                    onRefresh: () async {
                      _favoritesCubit.fectchFavCycle();
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / .87),
                      itemCount: favCycles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: AppTheme.cycleContainer(
                            context,
                            cycle: favCycles[index],
                            onTap: () => Navigator.pushNamed(
                                context, Routes.cycleDescription,
                                arguments: {'cycleId': favCycles[index].id}),
                          ),
                        );
                      },
                    ),
                  );
          }
          if (state is ErrorFavorite) {
            return EmptyDataMessage.emptyDataMessage(
                message: state.errorMessage);
          }
          return EmptyDataMessage.emptyDataMessage(
              message: 'Server error. Please try again later.');
        },
      ),
    );
  }
}

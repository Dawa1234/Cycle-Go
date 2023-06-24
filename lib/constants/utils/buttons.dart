import 'package:cyclego/constants/enums/enum.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/favorites/favorites_cubit.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/screens/search_screen.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileButton extends StatelessWidget {
  final Function()? onTap;
  const ProfileButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state is ProfileFecthed
            ? Padding(
                // padding: const EdgeInsets.all(0),
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                      image: state.userData!.profileImage!.isNotEmpty
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(state.userData!.profileImage!))
                          : null,
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Theme.of(context).highlightColor)
                      ]),
                  child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      iconSize: 20,
                      onPressed: onTap ??
                          () => Navigator.pushNamed(context, Routes.profile),
                      icon: state.userData!.profileImage!.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: Colors.green,
                            )
                          : const SizedBox()),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class SearchButton extends StatelessWidget {
  final Function()? onTap;
  final CurrentScreen currentScreen;
  const SearchButton({Key? key, this.onTap, required this.currentScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Theme.of(context).highlightColor)
            ]),
        child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            iconSize: 20,
            onPressed: onTap ??
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchBy: currentScreen),
                    )),
            icon: const Icon(
              Icons.search,
              color: Colors.green,
            )),
      ),
    );
  }
}

class FavButton extends StatefulWidget {
  final Function()? onTap;
  final String cycleId;
  const FavButton({
    Key? key,
    this.onTap,
    required this.cycleId,
  }) : super(key: key);

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  late FavoritesCubit _favoritesCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesCubit = BlocProvider.of<FavoritesCubit>(context)
      ..init(cycleId: widget.cycleId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      bloc: _favoritesCubit,
      listener: (context, state) {
        if (state is FavoritesFetching) {
          PageLoading.showProgress(context);
        }
        if (state is AddedCycleToFav) {
          Navigator.pop(context);
          getIt.get<FavoritesCubit>().fectchFavCycle();
          SnackBarMessage.successMessage(context,
              message: state.successMessage);
        }
        if (state is RemovedCycleFromFav) {
          Navigator.pop(context);
          getIt.get<FavoritesCubit>().fectchFavCycle();
          SnackBarMessage.successMessage(context,
              message: state.successMessage);
        }
        if (state is ErrorFavorite) {
          Navigator.pop(context);
          SnackBarMessage.errorMessage(context, message: state.errorMessage);
        }
      },
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return Padding(
            // padding: const EdgeInsets.all(0),
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Theme.of(context).highlightColor)
                  ]),
              child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  iconSize: 20,
                  onPressed: () => _handleFavAction(state),
                  icon: _getIcon(state)),
            ),
          );
        },
      ),
    );
  }

  _handleFavAction(FavoritesState state) {
    if (state is CycleIsFavorite) {
      if (state.isFav) {
        _favoritesCubit.removeCycleFromFav(cycleId: widget.cycleId);
      } else {
        _favoritesCubit.addCycleToFav(cycleId: widget.cycleId);
      }
    }
    if (state is AddedCycleToFav) {
      _favoritesCubit.removeCycleFromFav(cycleId: widget.cycleId);
    }
    if (state is RemovedCycleFromFav) {
      _favoritesCubit.addCycleToFav(cycleId: widget.cycleId);
    }
  }

  Icon _getIcon(FavoritesState state) {
    if (state is CycleIsFavorite) {
      if (state.isFav) {
        return const Icon(
          Icons.favorite,
          color: Colors.red,
        );
      } else {
        return const Icon(Icons.favorite, color: Colors.grey);
      }
    } else if (state is AddedCycleToFav) {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
    return const Icon(
      Icons.favorite,
      color: Colors.grey,
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Function()? onTap;
  const LanguageButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Theme.of(context).highlightColor)
              ]),
          child: const Text(
            "EN",
            style: TextStyle(letterSpacing: 1, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

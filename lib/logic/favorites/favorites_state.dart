part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState extends Equatable {}

class FavoritesInitial extends FavoritesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoritesFetching extends FavoritesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CycleIsFavorite extends FavoritesState {
  final bool isFav;
  CycleIsFavorite({
    required this.isFav,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [isFav];
}

class AddedCycleToFav extends FavoritesState {
  final String successMessage;
  AddedCycleToFav({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class RemovedCycleFromFav extends FavoritesState {
  final String successMessage;
  RemovedCycleFromFav({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class FavoritesFetched extends FavoritesState {
  final List<CycleModel> favCycles;
  FavoritesFetched({required this.favCycles});
  @override
  // TODO: implement props
  List<Object?> get props => [favCycles];
}

class ErrorFavorite extends FavoritesState {
  final String errorMessage;
  ErrorFavorite({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

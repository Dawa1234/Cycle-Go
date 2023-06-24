import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/data/repository/cycleRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  CycleRepository cycleRepository = CycleRepository();
  FavoritesCubit() : super(FavoritesInitial());

  init({required String cycleId}) async {
    emit(FavoritesFetching());
    try {
      bool isFav = await cycleRepository.cycleIsFav(cycleId: cycleId);
      emit(CycleIsFavorite(isFav: isFav));
    } catch (e) {
      emit(ErrorFavorite(errorMessage: e.toString()));
    }
  }

  addCycleToFav({required String cycleId}) async {
    emit(FavoritesFetching());
    try {
      final response = await cycleRepository.addCycleToFav(cycleId: cycleId);
      if (response['success']) {
        emit(AddedCycleToFav(successMessage: response['data']));
      } else {
        emit(ErrorFavorite(errorMessage: response['error']));
      }
    } catch (e) {
      emit(ErrorFavorite(errorMessage: e.toString()));
    }
  }

  removeCycleFromFav({required String cycleId}) async {
    emit(FavoritesFetching());
    try {
      final response =
          await cycleRepository.removeCycleFromFav(cycleId: cycleId);
      if (response['success']) {
        emit(RemovedCycleFromFav(successMessage: response['data']));
      } else {
        emit(ErrorFavorite(errorMessage: response['error']));
      }
    } catch (e) {
      emit(ErrorFavorite(errorMessage: e.toString()));
    }
  }

  fectchFavCycle() async {
    emit(FavoritesFetching());
    try {
      List<CycleModel> favCycles = await cycleRepository.fetchFavCycle();
      emit(FavoritesFetched(favCycles: favCycles));
    } catch (e) {
      emit(ErrorFavorite(errorMessage: e.toString()));
    }
  }

  filterFavCycle(
      {required List<CycleModel> allFavCycles,
      required String cycleName}) async {
    emit(FavoritesFetching());
    try {
      List<CycleModel> filteredfavCycles = allFavCycles
          .where((element) =>
              element.name!.toLowerCase().contains(cycleName.toLowerCase()))
          .toList();

      emit(FilterFavorites(favCycles: filteredfavCycles));
    } catch (e) {
      emit(ErrorFavorite(errorMessage: e.toString()));
    }
  }

  fetchedFavCycle({required List<CycleModel> favCycles}) {
    emit(FavoritesFetched(favCycles: favCycles));
  }
}

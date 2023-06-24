import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/data/repository/cycleRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'booked_cycle_state.dart';

class BookedCycleCubit extends Cubit<BookedCycleState> {
  CycleRepository cycleRepository = CycleRepository();
  BookedCycleCubit() : super(BookedCycleInitial());

  init() async {
    emit(BookedCycleFetching());
    try {
      final response = await cycleRepository.fetchBookedCycles();
      if (response['success']) {
        emit(BookedCycleFetched(bookedCycles: response['data']));
      } else {
        emit(ErrorBookedCycle(errorMessage: response['error']));
      }
    } catch (e) {
      emit(ErrorBookedCycle(errorMessage: e.toString()));
    }
  }

  filterBookedCycle(
      {required List<CycleModel> bookedCycles, required String cycleName}) {
    List<CycleModel> filteredBookedCycles = bookedCycles
        .where((element) =>
            element.name!.toLowerCase().contains(cycleName.toLowerCase()))
        .toList();

    emit(FilteredBookedCycle(bookedCycles: filteredBookedCycles));
  }

  fetchedBookedCycle({
    required List<CycleModel> bookedCycles,
  }) {
    emit(BookedCycleFetched(bookedCycles: bookedCycles));
  }
}

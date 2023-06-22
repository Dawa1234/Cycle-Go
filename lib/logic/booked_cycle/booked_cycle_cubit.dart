import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'booked_cycle_state.dart';

class BookedCycleCubit extends Cubit<BookedCycleState> {
  BookedCycleCubit() : super(BookedCycleInitial());

  void init(BookedCycleInitial event, emit) {
    emit(BookedCycleFetching());
    try {} catch (e) {
      emit(ErrorBookedCycle(errorMessage: e.toString()));
    }
  }
}

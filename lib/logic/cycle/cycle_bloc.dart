import 'package:bloc/bloc.dart';
import 'package:cyclego/data/repository/cycleRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cycle_event.dart';
part 'cycle_state.dart';

class CycleBloc extends Bloc<CycleEvent, CycleState> {
  CycleRepository cycleRepository = CycleRepository();
  CycleBloc() : super(CycleInitial()) {
    on<InitialCycleEvent>(_init);
  }

  _init(event, emit) {
    cycleRepository.getAllCycels();
  }
}

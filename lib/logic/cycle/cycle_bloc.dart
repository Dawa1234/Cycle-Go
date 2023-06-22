import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/data/repository/cycleRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cycle_event.dart';
part 'cycle_state.dart';

class CycleBloc extends Bloc<CycleEvent, CycleState> {
  CycleRepository cycleRepository = CycleRepository();
  CycleBloc() : super(CycleInitial()) {
    on<InitialCycleEvent>(_init);
    on<AddCycleEvent>(_addNewCycle);
    on<FetchCycleDetailEvent>(_fetchCycleDetail);
  }

  _init(event, emit) async {
    emit(CycleLoading());
    try {
      Map<String, dynamic> response = await cycleRepository.getAllCycels();
      if (response['success']) {
        emit(CycleFetched(allCycles: response['data']));
      } else {
        emit(ErrorCycle(error: response['error']));
      }
    } catch (e) {
      emit(ErrorCycle(error: e.toString()));
    }
  }

  _fetchCycleDetail(FetchCycleDetailEvent event, emit) async {
    emit(CycleLoading());
    try {
      Map<String, dynamic> response =
          await cycleRepository.fetchCycleDetail(cycleId: event.cycleId);
      if (response['success']) {
        emit(CycleDetailFetched(cycleDetail: response['data']));
      } else {
        emit(ErrorCycle(error: response['error']));
      }
    } catch (e) {
      emit(CycleLoading());
    }
  }

  _addNewCycle(event, emit) async {
    emit(CycleLoading());
    try {
      Map<String, dynamic> response = await cycleRepository.addNewCycle();
      if (response['success']) {
        emit(CycleAdded(successMessage: response['data']));
      } else {
        emit(ErrorCycle(error: response['error']));
      }
    } catch (e) {
      emit(ErrorCycle(error: e.toString()));
    }
  }
}

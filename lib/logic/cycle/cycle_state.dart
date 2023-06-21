part of 'cycle_bloc.dart';

@immutable
abstract class CycleState extends Equatable {}

class CycleInitial extends CycleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CycleLoading extends CycleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredCycle extends CycleState {
  final List<CycleModel> allCycle;
  FilteredCycle({required this.allCycle});
  @override
  // TODO: implement props
  List<Object?> get props => [allCycle];
}

class CycleFetched extends CycleState {
  final List<CycleModel> allCycles;
  CycleFetched({required this.allCycles});
  @override
  // TODO: implement props
  List<Object?> get props => [allCycles];
}

class CycleDetailFetched extends CycleState {
  final CycleDetail cycleDetail;
  CycleDetailFetched({required this.cycleDetail});
  @override
  // TODO: implement props
  List<Object?> get props => [cycleDetail];
}

class ErrorCycle extends CycleState {
  final String error;
  ErrorCycle({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

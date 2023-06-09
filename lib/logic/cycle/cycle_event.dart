part of 'cycle_bloc.dart';

@immutable
abstract class CycleEvent extends Equatable {}

class InitialCycleEvent extends CycleEvent {
  @override
  List<Object?> get props => [];
}

class AddCycleEvent extends CycleEvent {
  final CycleDetail cycleDetail;
  AddCycleEvent({required this.cycleDetail});
  @override
  List<Object?> get props => [cycleDetail];
}

class RemoveCycleEvent extends CycleEvent {
  final String cycleId;
  RemoveCycleEvent({required this.cycleId});
  @override
  List<Object?> get props => [cycleId];
}

class FetchCycleDetailEvent extends CycleEvent {
  final String cycleId;
  FetchCycleDetailEvent({required this.cycleId});
  @override
  List<Object?> get props => [cycleId];
}

class BookCycleEvent extends CycleEvent {
  final String cycleId;
  BookCycleEvent({
    required this.cycleId,
  });
  @override
  List<Object?> get props => [cycleId];
}

class AddToFavCycleEvent extends CycleEvent {
  final String cycleId;
  AddToFavCycleEvent({
    required this.cycleId,
  });
  @override
  List<Object?> get props => [cycleId];
}

class FilterCycleEvent extends CycleEvent {
  final List<CycleModel> allCycles;
  final String cycleType;
  FilterCycleEvent({
    required this.allCycles,
    required this.cycleType,
  });
  @override
  List<Object?> get props => [allCycles, cycleType];
}

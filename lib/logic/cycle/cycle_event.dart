part of 'cycle_bloc.dart';

@immutable
abstract class CycleEvent extends Equatable {}

class InitialCycleEvent extends CycleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchCycleDetailEvent extends CycleEvent {
  String cycleId;
  FetchCycleDetailEvent({required this.cycleId});
  @override
  // TODO: implement props
  List<Object?> get props => [cycleId];
}

class BookCycleEvent extends CycleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToFavCycleEvent extends CycleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

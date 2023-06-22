part of 'booked_cycle_cubit.dart';

@immutable
abstract class BookedCycleState extends Equatable {}

class BookedCycleInitial extends BookedCycleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookedCycleFetching extends BookedCycleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookedCycleFetched extends BookedCycleState {
  final List<CycleModel> bookedCycles;
  BookedCycleFetched({required this.bookedCycles});
  @override
  // TODO: implement props
  List<Object?> get props => [bookedCycles];
}

class ErrorBookedCycle extends BookedCycleState {
  final String errorMessage;
  ErrorBookedCycle({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

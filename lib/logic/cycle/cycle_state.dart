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

class CycleAdded extends CycleState {
  final String successMessage;
  CycleAdded({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class FilteredCycle extends CycleState {
  final List<CycleModel> allCycles;
  FilteredCycle({
    required this.allCycles,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [allCycles];
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

class CycleBooked extends CycleState {
  final String successMessage;
  CycleBooked({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class CycleAddedToFav extends CycleState {
  final String successMessage;
  CycleAddedToFav({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class ErrorCycle extends CycleState {
  final String error;
  ErrorCycle({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

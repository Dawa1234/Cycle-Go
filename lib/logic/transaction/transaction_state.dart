part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {}

class TransactionInitial extends TransactionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TransactionInProgress extends TransactionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TransactionSuccess extends TransactionState {
  final String successMessage;
  TransactionSuccess({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}

class TransactionFailed extends TransactionState {
  final String failedMessage;
  TransactionFailed({required this.failedMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [failedMessage];
}

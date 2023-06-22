part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {}

class StartTxnEvent extends TransactionEvent {
  int amount;
  BuildContext context;
  StartTxnEvent({
    required this.amount,
    required this.context,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

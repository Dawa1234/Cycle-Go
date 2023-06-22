part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {}

class StartTxnEvent extends TransactionEvent {
  final String cycleId;
  final int amount;
  final BuildContext context;
  StartTxnEvent({
    required this.cycleId,
    required this.amount,
    required this.context,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [context, cycleId, amount];
}

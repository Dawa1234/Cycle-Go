import 'package:bloc/bloc.dart';
import 'package:cyclego/data/repository/transactionRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionRepository transactionRepository = TransactionRepository();
  TransactionBloc() : super(TransactionInitial()) {
    on<StartTxnEvent>(_startTxn);
  }

  _startTxn(StartTxnEvent event, emit) async {
    emit(TransactionInProgress());
    try {
      Map<String, dynamic> response = await transactionRepository.executeTxn(
          cycleId: event.cycleId, amount: event.amount, context: event.context);
      if (response['success']) {
        emit(TransactionSuccess(successMessage: response['data']));
      } else {
        emit(TransactionFailed(failedMessage: response['data']));
      }
    } catch (e) {
      emit(TransactionFailed(failedMessage: e.toString()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/data/transaction_configuration.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class TransactionRepository {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = getIt.get<FirebaseFirestore>();
  FirebaseStorage firebaseStorage = getIt.get<FirebaseStorage>();

  Future<Map<String, dynamic>> executeTxn(
      {required String cycleId,
      required int amount,
      required BuildContext context}) async {
    Map<String, dynamic> message = {};
    try {
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // booking process
      await KhaltiScope.of(context).pay(
        config: TransactionConfiguration.config(amount: amount * 100),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (successModel) async {
          message =
              responseMessage(success: true, data: "Transaction Success.");
          BlocProvider.of<CycleBloc>(context)
              .add(BookCycleEvent(cycleId: cycleId));
        },
        onFailure: (failureModel) {
          message = responseMessage(
              success: false,
              error: "Could not execute transaction at the moment.");
        },
        onCancel: () {
          message =
              responseMessage(success: false, error: "Transaction Cancelled.");
        },
      );
      return message;
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }
}

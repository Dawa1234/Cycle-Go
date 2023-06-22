import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/data/transaction_configuration.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class TransactionRepository {
  Future<Map<String, dynamic>> executeTxn(
      {required int amount, required BuildContext context}) async {
    Map<String, dynamic> message = {};
    try {
      await KhaltiScope.of(context).pay(
        config: TransactionConfiguration.config(amount: 1000),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (successModel) {
          message = responseMessage(success: true, data: "Success");
        },
        onFailure: (failureModel) {
          message = responseMessage(
              success: false,
              data: "Could not execute transaction at the momnet.");
        },
        onCancel: () {
          message =
              responseMessage(success: false, data: "Transaction Cancelled.");
        },
      );
      return message;
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }
}

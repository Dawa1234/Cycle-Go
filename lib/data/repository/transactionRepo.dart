import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/constants/urls.dart';
import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/data/transaction_configuration.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
      final email = firebaseAuth.currentUser!.email;
      await KhaltiScope.of(context).pay(
        config: TransactionConfiguration.config(amount: amount * 100),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (successModel) async {
          await firebaseFirestore
              .collection(CycleGoUrls.cycleUrl)
              .doc(cycleId)
              .set({'bookedStatus': true});
          await firebaseFirestore
              .collection(CycleGoUrls.cycleUrl)
              .doc(cycleId)
              .collection(CycleGoUrls.cycleDetail)
              .doc(cycleId)
              .set({
            'bookedStatus': true,
            'bookedDate': "",
            'returnDate': "",
          });
          await firebaseFirestore
              .collection(CycleGoUrls.bookedCycles)
              .doc(email)
              .set({
            'email': email,
            'cycleId': cycleId,
          });
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

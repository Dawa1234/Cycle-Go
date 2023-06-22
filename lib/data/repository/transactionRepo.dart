import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/constants/urls.dart';
import 'package:cyclego/data/models/cycle.dart';
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
      List<CycleModel> bookedCycles = [];
      final email = firebaseAuth.currentUser!.email;
      CycleModel cycleModel = CycleModel();
      String date = DateTime.now().toString();
      String currentDate = date.split(' ')[0] +
          " " +
          date.split(' ')[1].split(':')[0] +
          ":" +
          date.split(' ')[1].split(':')[1];

      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // booking process
      await KhaltiScope.of(context).pay(
        config: TransactionConfiguration.config(amount: amount * 100),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (successModel) async {
          await firebaseFirestore
              .collection(CycleGoUrls.cycleUrl)
              .doc(cycleId)
              .update({'bookedStatus': true});
          await firebaseFirestore
              .collection(CycleGoUrls.cycleUrl)
              .doc(cycleId)
              .collection(CycleGoUrls.cycleDetail)
              .doc(cycleId)
              .update({
            'bookedStatus': true,
            'bookedDate': currentDate,
            'returnDate': "",
          });
          await firebaseFirestore
              .collection(CycleGoUrls.cycleUrl)
              .doc(cycleId)
              .get()
              .then((value) {
            cycleModel = CycleModel.fromJson(value.data()!);
          });
          await firebaseFirestore
              .collection(CycleGoUrls.bookedCycles)
              .doc(email)
              .get()
              .then((value) {
            bookedCycles.add(cycleModel);
            if (value.exists) {
              for (var data in value.data()!['bookedCycles']) {
                bookedCycles.add(CycleModel.fromJson(data));
              }
            }
          });
          await firebaseFirestore
              .collection(CycleGoUrls.bookedCycles)
              .doc(email)
              .set({
            'bookedCycles':
                bookedCycles.map((cycleModel) => cycleModel.toJson()).toList(),
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

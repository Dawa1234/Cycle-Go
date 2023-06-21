import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CycleRepository {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = getIt.get<FirebaseFirestore>();
  Future getAllCycels() async {
    try {
      var data = await firebaseFirestore.collection('users').get();
      log(data.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}

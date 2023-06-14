import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> registerUser(
      String username, String password, UserModel userModel) async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: username, password: password);
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.email)
          .set(userModel.toJson());
      final data = {'success': true, 'user_credential': userCredential};
      return data;
    } catch (e) {
      log(e.toString());
      final error = {'success': false, 'error': e.toString()};
      return error;
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    UserCredential userCredential;
    try {
      // handle login
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      // fetch rest of the data
      var responseData = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.email)
          .get();
      // check fetched data
      if (responseData.data() != null) {
        UserModel user = UserModel.fromJson(responseData.data()!);
        final data = {'success': true, 'user': user};
        return data;
      } else {
        return {'success': false, 'error': 'User does not exist.'};
      }
    } catch (e) {
      final error = {'success': false, 'error': e.toString().split(']')[1]};
      return error;
    }
  }
}

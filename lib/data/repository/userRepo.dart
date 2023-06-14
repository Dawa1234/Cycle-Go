import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> registerUser(
      String username, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: username, password: password);
      final data = {'success': true, 'user_credential': userCredential};
      return data;
    } catch (e) {
      log(e.toString());
      final error = {'success': false, 'error': e.toString()};
      return error;
    }
  }
}

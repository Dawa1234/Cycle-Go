import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = getIt.get<FirebaseFirestore>();
  FirebaseStorage firebaseStorage = getIt.get<FirebaseStorage>();

  Future<Map<String, dynamic>> registerUser(
      String username, String password, UserModel userModel) async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: username, password: password);
      // set id of user
      userModel.uid = userCredential.user!.uid;
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

  Future<Map<String, dynamic>> profileUpdate({required File imageFile}) async {
    bool profileImageUpdated = false;
    UserModel? user;
    try {
      // updated profile
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      final userId = firebaseAuth.currentUser!.uid;
      final email = firebaseAuth.currentUser!.email;
      Reference ref = firebaseStorage.ref('user_profile/image/$userId');
      await ref.putFile(File(imageFile.path)).catchError((e) {
        print(e.toString());
      });
      String profileUrl = await ref.getDownloadURL();
      await firebaseFirestore
          .collection('users')
          .doc(email)
          .update({'profileImage': profileUrl}).whenComplete(
              () => profileImageUpdated = true);
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // get udpated profile
      await firebaseFirestore
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });
      if (profileUrl != null || profileUrl.isNotEmpty) {
        if (profileImageUpdated && user != null) {
          final success = {
            'success': true,
            'user': user,
          };
          return success;
        }
        final unSuccess = {
          'success': false,
          'error': "Error setting profile picture.",
        };
      }
      final unSuccess = {
        'success': false,
        'error': "Error setting profile picture.",
      };
      return unSuccess;
    } catch (e) {
      final error = {
        'success': false,
        'error': e.toString(),
      };
      return error;
    }
  }
}

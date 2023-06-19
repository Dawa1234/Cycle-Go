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

  Future<Map<String, dynamic>> profilePicUpdate({
    required File imageFile,
    required bool toRemove,
  }) async {
    bool profileImageUpdated = false;
    String profileUrl = "";
    UserModel? user;
    try {
      final unSuccess = {
        'success': false,
        'error': "Error setting profile picture.",
      };
      // updated profile
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      final userId = firebaseAuth.currentUser!.uid;
      final email = firebaseAuth.currentUser!.email;
      Reference ref = firebaseStorage.ref('user_profile/image/$userId');
      if (!toRemove) {
        await ref
            .putFile(File(imageFile.path))
            .catchError((e) => log(e.toString()));
        profileUrl = await ref.getDownloadURL();
        await firebaseFirestore
            .collection('users')
            .doc(email)
            .update({'profileImage': profileUrl}).whenComplete(
                () => profileImageUpdated = true);
      } else {
        await ref.delete();
        await firebaseFirestore
            .collection('users')
            .doc(email)
            .update({'profileImage': ""}).whenComplete(
                () => profileImageUpdated = true);
      }
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // get udpated profile
      await firebaseFirestore
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });
      if (profileImageUpdated && user != null) {
        final success = {
          'success': true,
          'user': user,
        };
        return success;
      }

      return unSuccess;
    } catch (e) {
      final error = {
        'success': false,
        'error': e.toString(),
      };
      return error;
    }
  }

  Future<Map<String, dynamic>> updateProfileInfo(
      {required String firstName, required String lastName}) async {
    bool updated = false;
    UserModel? user;
    final unSuccess = {
      'success': false,
      'error': 'Unable to update.',
    };
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore.collection('users').doc(email).update({
        'firstName': firstName,
        'lastName': lastName,
      }).whenComplete(() => updated = true);
      await firebaseFirestore
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });

      if (updated && user != null) {
        final success = {
          'success': true,
          'user': user,
        };
        return success;
      }
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

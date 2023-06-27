import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/constants/urls.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          .collection(CycleGoUrls.userUrl)
          .doc(userCredential.user!.email)
          .set(userModel.toJson());
      return responseMessage(success: true, data: userCredential);
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> loginUser(String username, String password,
      {required bool useGoogle}) async {
    UserCredential userCredential;
    final googleSignIn = GoogleSignIn();
    GoogleSignInAuthentication googleAuth;
    AuthCredential? credential;
    try {
      // handle login
      if (useGoogle) {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          googleAuth = await googleSignInAccount.authentication;
          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
        }
        userCredential = await firebaseAuth.signInWithCredential(credential!);
        return responseMessage(
            success: true,
            data: UserModel(
                uid: userCredential.user!.uid,
                email: userCredential.user!.email,
                password: "",
                firstName: userCredential.user!.displayName,
                lastName: "",
                profileImage: userCredential.user!.photoURL));
        // await firebaseAuth.createUserWithEmailAndPassword(
        //     email: userCredential.user!.email!,
        //     password: userCredential.user!.uid);
        // await firebaseFirestore
        //     .collection(CycleGoUrls.userUrl)
        //     .doc(userCredential.user!.email)
        //     .set(UserModel(
        //       firstName: userCredential.user!.displayName,
        //       email: userCredential.user!.email,
        //       uid: userCredential.user!.uid,
        //       password: userCredential.user!.uid,
        //       profileImage: userCredential.user!.photoURL,
        //     ).toJson());
      } else {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: username, password: password);
      }

      // fetch rest of the data
      DocumentSnapshot<Map<String, dynamic>> responseData =
          await firebaseFirestore
              .collection(CycleGoUrls.userUrl)
              .doc(userCredential.user!.email)
              .get();
      // check fetched data
      if (responseData.data() != null) {
        UserModel user = UserModel.fromJson(responseData.data()!);
        return responseMessage(success: true, data: user);
      } else {
        return responseMessage(success: false, error: 'User does not exist.');
      }
    } catch (e) {
      final String error = e.toString().split(']')[1];
      return responseMessage(success: false, error: error);
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
            .collection(CycleGoUrls.userUrl)
            .doc(email)
            .update({'profileImage': profileUrl}).whenComplete(
                () => profileImageUpdated = true);
      } else {
        await ref.delete();
        await firebaseFirestore
            .collection(CycleGoUrls.userUrl)
            .doc(email)
            .update({'profileImage': ""}).whenComplete(
                () => profileImageUpdated = true);
      }
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // get udpated profile
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });
      if (profileImageUpdated && user != null) {
        return responseMessage(success: true, data: user);
      }

      return responseMessage(
          success: false, error: "Error setting profile picture.");
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
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
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .update({
        'firstName': firstName,
        'lastName': lastName,
      }).whenComplete(() => updated = true);
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });

      if (updated && user != null) {
        final success = {
          'success': true,
          'data': user,
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

  Future<Map<String, dynamic>> updatePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      UserModel? user;
      bool passwordMatched = false;
      bool passwordUpdated = false;
      final unSuccess = {
        'success': false,
        'error': 'Current password did not match.',
      };
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // password match validation
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .get()
          .then((value) {
        if (value.data()!['password'] == currentPassword) {
          passwordMatched = true;
        }
      });
      if (!passwordMatched) return unSuccess;
      // -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
      // update password
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .update({'password': newPassword});
      await firebaseFirestore
          .collection(CycleGoUrls.userUrl)
          .doc(email)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
      });
      await firebaseAuth.currentUser!
          .updatePassword(newPassword)
          .whenComplete(() => passwordUpdated = true);
      if (!passwordUpdated) return unSuccess;
      final success = {
        'success': true,
        'data': user,
      };
      return success;
    } catch (e) {
      final error = {
        'success': false,
        'error': e.toString(),
      };
      return error;
    }
  }
}

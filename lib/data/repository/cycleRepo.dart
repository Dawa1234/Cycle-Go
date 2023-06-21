import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/constants/urls.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CycleRepository {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = getIt.get<FirebaseFirestore>();

  Future<Map<String, dynamic>> getAllCycels() async {
    AllCycles? allCycles;
    List cycleData = [];
    try {
      await firebaseFirestore
          .collection(CycleGoUrls.cycleUrl)
          .get()
          .then((value) {
        // collecting data
        for (var data in value.docs) {
          cycleData.add(data.data());
        }
        Map<String, dynamic> data = {'data': cycleData};
        allCycles = AllCycles.fromJson(data);
      });
      if (allCycles == null) {
        return responseMessage(success: false, error: 'Could not fetch data.');
      }
      return responseMessage(success: true, data: allCycles!.data);
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchCycleDetail(
      {required String cycleId}) async {
    CycleDetail? cycleDetail;
    try {
      await firebaseFirestore
          .collection(CycleGoUrls.cycleUrl)
          .doc(cycleId)
          .collection(CycleGoUrls.cycleDetail)
          .doc(cycleId)
          .get()
          .then((value) {
        cycleDetail = CycleDetail.fromJson(value.data()!);
      });
      if (cycleDetail == null) {
        return responseMessage(success: false, error: 'Could not fetch data');
      }
      return responseMessage(success: true, data: cycleDetail);
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }
}

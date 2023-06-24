import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/constants/urls.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/data/repository/response.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

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

  Future<Map<String, dynamic>> addNewCycle(
      // {required CycleDetail cycleDetail}
      ) async {
    bool cycleCreated = false;
    bool cycleAdded = false;
    const uuid = Uuid();
    String id = uuid.v1();
    CycleDetail cycleDetail = CycleDetail(
        bookedDate: "",
        color: "Red",
        bookedStatus: false,
        description:
            "stability and balance in natural systems. They regulate and maintain equilibrium by balancing opposing forces or processes",
        id: id.toString(),
        image: [
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBgRS0zEpRLPWZD2pBfw5ikGqZnPLiZJ0KJQ&usqp=CAU",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBgRS0zEpRLPWZD2pBfw5ikGqZnPLiZJ0KJQ&usqp=CAU",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBgRS0zEpRLPWZD2pBfw5ikGqZnPLiZJ0KJQ&usqp=CAU",
        ],
        name: "Hercules",
        price: "200",
        rating: 4.8,
        returnDate: "",
        speed: 110,
        type: "Road");
    CycleModel cycleModel = CycleModel(
        bookedStatus: cycleDetail.bookedStatus,
        id: cycleDetail.id,
        image: cycleDetail.image!.toList(),
        name: cycleDetail.name,
        price: cycleDetail.price,
        type: cycleDetail.type);
    try {
      await firebaseFirestore
          .collection(CycleGoUrls.cycleUrl)
          .doc(id.toString())
          .set(cycleModel.toJson())
          .whenComplete(() => cycleCreated = true);
      await firebaseFirestore
          .collection(CycleGoUrls.cycleUrl)
          .doc(id.toString())
          .collection(CycleGoUrls.cycleDetail)
          .doc(id.toString())
          .set(cycleDetail.toJson())
          .whenComplete(() => cycleAdded = true);

      if (!(cycleCreated && cycleAdded)) {
        return responseMessage(
            success: true, data: 'Cannot add at the moment.');
      }
      return responseMessage(success: true, data: 'Successfully Added');
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchBookedCycles() async {
    AllCycles bookedCycles = AllCycles();
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.bookedCycles)
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          bookedCycles = AllCycles.fromJson(value.data()!);
        }
      });
      if (bookedCycles.data == null || bookedCycles.data!.isEmpty) {
        return responseMessage(success: true, data: <CycleModel>[]);
      }
      return responseMessage(success: true, data: bookedCycles.data);
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> bookACycle({required String cycleId}) async {
    List<CycleModel> bookedCycles = [];
    final email = firebaseAuth.currentUser!.email;
    CycleModel cycleModel = CycleModel();
    String date = DateTime.now().toString();
    bool success = false;
    String currentDate = date.split(' ')[0] +
        " " +
        date.split(' ')[1].split(':')[0] +
        ":" +
        date.split(' ')[1].split(':')[1];
    try {
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
          for (var data in value.data()!['data']) {
            bookedCycles.add(CycleModel.fromJson(data));
          }
        }
      });
      await firebaseFirestore
          .collection(CycleGoUrls.bookedCycles)
          .doc(email)
          .set({
        'data': bookedCycles.map((cycleModel) => cycleModel.toJson()).toList(),
      }).whenComplete(() => success = true);
      if (!success) {
        return responseMessage(
            success: false, error: "Please try again later.");
      }
      return responseMessage(success: success, data: 'Succfully booked.');
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> addCycleToFav({required String cycleId}) async {
    CycleModel cycleModel = CycleModel();
    AllCycles allCycles = AllCycles();
    List<CycleModel> existingFavCycle = [];
    bool addedToFav = false;
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.cycleUrl)
          .doc(cycleId)
          .get()
          .then((value) {
        cycleModel = CycleModel.fromJson(value.data()!);
      });
      await firebaseFirestore
          .collection(CycleGoUrls.favorites)
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          allCycles = AllCycles.fromJson(value.data()!);
          existingFavCycle = allCycles.data!;
        }
        existingFavCycle.add(cycleModel);
      });
      await firebaseFirestore.collection(CycleGoUrls.favorites).doc(email).set({
        'data': existingFavCycle.map((cycle) => cycle.toJson()).toList()
      }).whenComplete(() => addedToFav = true);
      if (!addedToFav) {
        return responseMessage(
            success: false, error: "Could not add at the moment.");
      }
      return responseMessage(success: true, data: "Added To Favorites.");
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> removeCycleFromFav(
      {required String cycleId}) async {
    CycleModel cycleModel = CycleModel();
    AllCycles allCycles = AllCycles();
    bool removeFromFav = false;
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.favorites)
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          allCycles = AllCycles.fromJson(value.data()!);
        }
        cycleModel =
            allCycles.data!.firstWhere((element) => element.id == cycleId);
        allCycles.data!.remove(cycleModel);
      });
      await firebaseFirestore.collection(CycleGoUrls.favorites).doc(email).set({
        'data': allCycles.data!.map((cycle) => cycle.toJson()).toList()
      }).whenComplete(() => removeFromFav = true);
      if (!removeFromFav) {
        return responseMessage(
            success: false, error: "Could not remove at the moment.");
      }
      return responseMessage(success: true, data: "Removed From Favorites.");
    } catch (e) {
      return responseMessage(success: false, error: e.toString());
    }
  }

  Future<bool> cycleIsFav({required String cycleId}) async {
    AllCycles allCycles = AllCycles();
    bool isFav = false;
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.favorites)
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          allCycles = AllCycles.fromJson(value.data()!);
        }
      });
      if (allCycles.data != null) {
        for (var data in allCycles.data!) {
          if (data.id == cycleId) {
            isFav = true;
            break;
          }
        }
      }
      return isFav;
    } catch (e) {
      return isFav;
    }
  }

  Future<List<CycleModel>> fetchFavCycle() async {
    AllCycles allCycles = AllCycles();
    try {
      final email = firebaseAuth.currentUser!.email;
      await firebaseFirestore
          .collection(CycleGoUrls.favorites)
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          allCycles = AllCycles.fromJson(value.data()!);
        }
      });
      return allCycles.data ?? [];
    } catch (e) {
      return [];
    }
  }
}

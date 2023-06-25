import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:cyclego/logic/favorites/favorites_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

setUpLocator() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  getIt.registerLazySingleton<CycleBloc>(() => CycleBloc());
  getIt.registerLazySingleton<FavoritesCubit>(() => FavoritesCubit());
}

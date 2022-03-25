import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/services/pref_service.dart';

class DataService {

  //
  static final instance = FirebaseFirestore.instance;

  ///
  static const String userFolder = "users";

  // User store
  static Future storeUser(Users user) async {
    user.uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(userFolder).doc(user.uid).set(user.toJson());
  }

  // User load
  static Future<Users> loadUser() async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    var value = await instance.collection(userFolder).doc(uid).get();
    return Users.fromJson(value.data()!);
  }

  // User update
  static Future updateUser(Users user) async {
    String uid = (await Prefs.load(StorageKeys.UID))!;
    return instance.collection(userFolder).doc(uid).update(user.toJson());
  }

  // User search
  static Future<List<Users>> searchUsers(String keyword) async {
    List<Users> users = [];
    var querySnapshot = await instance.collection(userFolder).orderBy("fullname").startAt([keyword]).get();

    if (kDebugMode) {
      print("\nQuery Snapshots => ${querySnapshot.docs.toString()}\n");
    }

    for (var element in querySnapshot.docs) {
      users.add(Users.fromJson(element.data()));
    }

    return users;
  }
}
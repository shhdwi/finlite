import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlite/Constants.dart';
import 'package:finlite/database_coin/sharedprefs.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{

  Future addCoin(
      String emailId, Map<String,dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("holdings")
        .doc(emailId)
        .set(messageInfoMap);
  }
  Future getLeader() async {
    DocumentSnapshot<Map<String, dynamic>> collection = await FirebaseFirestore.instance.collection('users').doc().get();
    Map<dynamic, dynamic> list =collection.data() as Map<dynamic,dynamic>;
    print(collection.runtimeType);
    print(list);
    return list;

  }
  Future<List<Map<String, dynamic>>> getData() async {
    // Get docs from collection reference
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    // Get data from docs and convert map to List
    final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(_docData);
    return _docData;



  }



  Future addUser(
      String emailId, Map<String,dynamic> UserInfomap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(emailId)
        .set(UserInfomap);
  }
  Future<QuerySnapshot> getUserInfo(String mail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: mail)
        .get();
  }
  Future addCoindata(
      String emailId, String symbol, Map<String,dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(emailId)
        .collection(symbol)
        .doc(emailId)
        .set(messageInfoMap);
  }
  Future getCoins(emailId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(emailId)
        .collection("holdings").doc();
  }
  createUser(String userId, Map<String,dynamic> userInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (snapShot.exists) {
      getUserInfo(userId);
      var data = snapShot.data();
      print(data!["portfolio"].runtimeType);
      portfolio=data["portfolio"];
      SharedPreferenceHelper().saveportfolio(portfolio);
      SharedPreferenceHelper().saveusermail(userId);
      print(portfolio);
      print("gg leaderboard");
      getData();




      await FirebaseFirestore.instance
          .collection("holdings")
          .doc(userId)
          .get().then((snapshot) async {

        Map<String, Map<String,dynamic>> map =  Map<String, Map<String,dynamic>>.from(snapshot.data() as Map<String,dynamic>);
        holdings = Map<String, Map<String,dynamic>>.from(map["coin"] as Map<String,dynamic>);
        print("gg Holdings: ");
        print(holdings);
      });
      // user already exists
      return true;
    } else {
      SharedPreferenceHelper().saveportfolio(userInfoMap["portfolio"]);
      SharedPreferenceHelper().saveusermail(userId);
      // user does not exists
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .set(userInfoMap);


    }
  }



}

import 'package:business_app/models/business_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileProvider extends ChangeNotifier {
  bool _showProfiles = false;
  List<BusinessData> _businessProfiles = [];

  bool get showProfiles => _showProfiles;
  List<BusinessData> get businessProfiles => _businessProfiles;

  void showProfileLists() {
    _showProfiles = !_showProfiles;
    debugPrint("CLICKED TOGGLE EYE");
    notifyListeners();
  }

  Future<void> createBusinessProfile(
    String businessName,
    String businessWrbsite,
    String businessBank,
    String location,
    String businessIndustry,
    String businessYear,
    String numberOfEmployees,
  ) async {
    try {
      print("enter business create");

      final businessInstance = BusinessData(
          nameOfTheBusiness: businessName,
          businessWebsite: businessWrbsite,
          businessBank: businessBank,
          location: location,
          businessIndustry: businessIndustry,
          businessEstablishedYear: businessYear,
          numberOfEmployees: numberOfEmployees);

      final userData = businessInstance.toMap();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("business")
          .doc()
          .set(userData)
          .then((val) {
        debugPrint("added business into firebase successfully ");
      });
    } catch (e) {
      print("error error error $e");

      
    }
  }


Future<void> loadBusinessProfiles() async {
    try {
      print("called loading function");
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("business")
          .get();

      _businessProfiles = querySnapshot.docs
          .map((doc) => BusinessData.fromMap(Map<String, String>.from(doc.data())))
          .toList();


      notifyListeners();
    } catch (e) {
      print("error loading business profiles: $e");
    }
  }

}

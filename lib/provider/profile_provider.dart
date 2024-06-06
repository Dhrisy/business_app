import 'package:business_app/models/business_data.dart';
import 'package:business_app/models/investor_data.dart';
import 'package:business_app/provider/business_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  bool _showProfiles = false;
  List<BusinessData> _businessProfiles = [];
  Map<String, dynamic> _userProfile = {};
  Map<String, dynamic> _loggedUserData = {};

  bool get showProfiles => _showProfiles;
  List<BusinessData> get businessProfiles => _businessProfiles;
  Map<String, dynamic> get userProfile => _userProfile;

  void showProfileLists() {
    _showProfiles = !_showProfiles;
    debugPrint("CLICKED TOGGLE EYE");
    notifyListeners();
  }

  void setUserProfile(Map<String, dynamic> profile) {
    _userProfile = profile;
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
    String businessLookingFor,
    String whichType,
    String userEmail,
    String userPhone,
    String userName
  ) async {
    try {
      print("enter business create");

      final businessInstance = BusinessData(
        businessLookingFor: businessLookingFor,
          nameOfTheBusiness: businessName,
          businessWebsite: businessWrbsite,
          businessBank: businessBank,
          location: location,
          whichType: whichType,
          businessIndustry: businessIndustry,
          businessEstablishedYear: businessYear,
          numberOfEmployees: numberOfEmployees,
          uid: FirebaseAuth.instance.currentUser!.uid,
          user_email: userEmail,
          user_name: userName,
          user_phone: userPhone
          
          );


          // /need to add user id

      final userData = businessInstance.toMap();
      await FirebaseFirestore.instance
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

   Future<void> createInvestorProfile(
    String companyName,
    String investmentRange,
    String investorIndustry,
    String location,
    String summary,
    String status,
    String preferredSector,
    String name,
    String email,
    String phone
  ) async {
    try {
      print("enter investor create");

      final businessInstance = InvestorData(
       investmentRange: investmentRange,
       investorCompanyName: companyName,
       investorIndustry: investorIndustry,
       investorSummary: summary,
       preferredSectors: preferredSector,
       status: status,
          location: location,

          uid: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          email: email,
          phone: phone
          );


          // /need to add user id

      final userData = businessInstance.toMap();
      await FirebaseFirestore.instance
          .collection("investors")
          .doc()
          .set(userData)
          .then((val) {
        debugPrint("added investors into firebase successfully ");
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
          .map((doc) =>
              BusinessData.fromMap(Map<String, String>.from(doc.data())))
          .toList();

      notifyListeners();
    } catch (e) {
      print("error loading business profiles: $e");
    }
  }




  Future<void> loadUserProfile(String userEmail) async {
    try {
      print("called user data function");

      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final exists = {"exists": true, "data": querySnapshot.docs};
        // User exists
        setUserProfile(exists);
      } else {
        final exists = {"exists": false, "data": null};
        setUserProfile(exists);
      }

      notifyListeners();
    } catch (e) {
      print("error loading user profile: $e");
      final exists = {"exists": false, "data": null};
      setUserProfile(exists);
    }
  }


 Future<void> isBookMarked(BuildContext context) async {
    print("nnnnnnnn");
    final businessProvider = Provider.of<BusinessProvider>(context);

    // final allBusiness = businessProvider.selectedBusiness;

    FirebaseFirestore.instance.collection('business').get().then((snapshot) {
      businessProvider.setSelectedBusiness(snapshot.docs);
    });

    // Fetch bookmarked businesses
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookmarked')
        .snapshots()
        .listen((snapshot) {
      businessProvider.setBookmarkedBusinesses(snapshot.docs);
    });

    print(
        "${businessProvider.bookmarkedBusinesses.length},  ${businessProvider.selectedBusiness.length}");
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessProvider extends ChangeNotifier{

   List<DocumentSnapshot> _selectedBusiness = [];
   String _businessDocId = "";
   List<DocumentSnapshot> _businesses = [];
  List<DocumentSnapshot> _bookmarkedBusinesses = [];


  List<DocumentSnapshot> get businesses => _businesses;
  List<DocumentSnapshot> get bookmarkedBusinesses => _bookmarkedBusinesses;
 List<DocumentSnapshot>  get selectedBusiness => _selectedBusiness;
 String get  businessDocId => _businessDocId;

 void setSelectedBusiness(List<DocumentSnapshot>  businessData) {
    _selectedBusiness = businessData;
    notifyListeners();
  }

  void setBusinessDocId(String id){

    _businessDocId = id;
    notifyListeners();

  }

  void setBookmarkedBusinesses(List<DocumentSnapshot> bookmarkedBusinesses) {
    _bookmarkedBusinesses = bookmarkedBusinesses;
    notifyListeners();
  }

  bool isBookmarked(String businessId) {
    return _bookmarkedBusinesses.any((doc) => doc.id == businessId);
  }



   
}
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  bool _searchResult = false;


  bool get searchResult => _searchResult;



  void setSearchResults(bool val){
    _searchResult = val;
    notifyListeners();

  }

  //  static bool? search(String searchFor, String searchIn) {
  //   return searchIn.toLowerCase().contains(searchFor.toLowerCase());
  // }

}
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier{
  bool _showProfiles = false;

  bool get showProfiles => _showProfiles;

  void showProfileLists() {
    _showProfiles = !_showProfiles;
    debugPrint("CLICKED TOGGLE EYE");
    notifyListeners();
  }



}
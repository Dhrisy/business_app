import 'package:shared_preferences/shared_preferences.dart';

import '../models/business_data.dart';

class saveToSharedPreferences {
  // void saveBusinessData(
  //   String nameOfTheBusiness,
  //   String businessWebsite,
  //   String businessBank,
  //   String location,
  //   String businessIndustry,
  //   String businessEstablishedYear,
  //   String numberOfEmployees,
  // ) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('name_of_business', nameOfTheBusiness);
  //   await prefs.setString('business_website', businessWebsite);
  //   await prefs.setString('business_bank', businessBank);
  //   await prefs.setString('business_location', location);
  //   await prefs.setString('business_industry', businessIndustry);
  //   await prefs.setString('number_of_employees', numberOfEmployees);
  //   await prefs.setString('business_established_year', businessEstablishedYear);
  // }



Future<void> saveBusinessData(BusinessData businessData) async {
  print("enter save");
    final prefs = await SharedPreferences.getInstance();
    final data = businessData.toMap();
    data.forEach((key, value) async {
      print("enter");
      await prefs.setString(key, value);
    });
    getBusinessData();
  }



  Future<BusinessData?> getBusinessData() async {
    print("get buiness");
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'name_of_business': prefs.getString('name_of_business') ?? '',
      'business_website': prefs.getString('business_website') ?? '',
      'business_bank': prefs.getString('business_bank') ?? '',
      'business_location': prefs.getString('business_location') ?? '',
      'business_industry': prefs.getString('business_industry') ?? '',
      'business_established_year': prefs.getString('business_established_year') ?? '',
      'number_of_employees': prefs.getString('number_of_employees') ?? '',
    };

    if (data.values.any((element) => element.isEmpty)) {
      print("some elemenet missing");
      return null;
    } else {
      print(BusinessData.fromMap(data));
      return BusinessData.fromMap(data);
    }
  }

  // void getBusinessData() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final name = await prefs.getString('name_of_business');
  //   final website =await prefs.getString('business_website');
  //   final bank =await prefs.getString('business_bank');
  //   final location =await prefs.getString('business_location');
  //   final industry =await prefs.getString('business_industry');
  //   final employees =await prefs.getString('number_of_employees');
  //   final year = await prefs.getString("business_established_year");

  //   print("${prefs.getString('name_of_business')}, $name, $bank, $location");

  // }



}

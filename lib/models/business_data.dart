class BusinessData {
  final String nameOfTheBusiness;
  final String businessWebsite;
  final String businessBank;
  final String location;
  final String businessIndustry;
  final String businessEstablishedYear;
  final String numberOfEmployees;
  final String businessLookingFor;
  final String whichType;
  final String uid;
  final String user_name;
  final String user_email;
  final String user_phone;

  BusinessData({
    required this.nameOfTheBusiness,
    required this.businessWebsite,
    required this.businessBank,
    required this.location,
    required this.businessIndustry,
    required this.businessEstablishedYear,
    required this.numberOfEmployees,
    required this.businessLookingFor,
     required this.uid,
      required this.whichType,
      required this.user_email,
      required this.user_name,
      required this.user_phone,
  });

  factory BusinessData.fromMap(Map<String, String> data) {
    return BusinessData(
      businessLookingFor: data["looking_for"] ?? '',
      nameOfTheBusiness: data['name_of_business'] ?? '',
      businessWebsite: data['business_website'] ?? '',
      businessBank: data['business_bank'] ?? '',
      location: data['business_location'] ?? '',
      businessIndustry: data['business_industry'] ?? '',
      businessEstablishedYear: data['business_established_year'] ?? '',
      numberOfEmployees: data['number_of_employees'] ?? '',
      uid: data['user_id'] ?? '',
      whichType: data['which_type'] ?? '',
      user_email: data['user_email'] ?? '',
      user_name: data['user_name'] ?? '',
      user_phone: data['user_phone'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name_of_business': nameOfTheBusiness,
      'business_website': businessWebsite,
      'business_bank': businessBank,
      'business_location': location,
      'business_industry': businessIndustry,
      'business_established_year': businessEstablishedYear,
      'number_of_employees': numberOfEmployees,
      "looking_for": businessLookingFor,
      "user_id": uid,
      "which_type": whichType,
      "user_name": user_name,
      "user_email": user_email,
      "user_phone": user_phone,
      "rupees": "50000",
      "company_name": "ABCD Company"
    };
  }
}

class BusinessData {
  final String nameOfTheBusiness;
  final String businessWebsite;
  final String businessBank;
  final String location;
  final String businessIndustry;
  final String businessEstablishedYear;
  final String numberOfEmployees;

  BusinessData({
    required this.nameOfTheBusiness,
    required this.businessWebsite,
    required this.businessBank,
    required this.location,
    required this.businessIndustry,
    required this.businessEstablishedYear,
    required this.numberOfEmployees,
  });

  factory BusinessData.fromMap(Map<String, String> data) {
    return BusinessData(
      nameOfTheBusiness: data['name_of_business'] ?? '',
      businessWebsite: data['business_website'] ?? '',
      businessBank: data['business_bank'] ?? '',
      location: data['business_location'] ?? '',
      businessIndustry: data['business_industry'] ?? '',
      businessEstablishedYear: data['business_established_year'] ?? '',
      numberOfEmployees: data['number_of_employees'] ?? '',
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
    };
  }
}

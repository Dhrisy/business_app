class InvestorData {
  final String investorCompanyName;
  final String investorIndustry;
  final String investmentRange;
  final String location;
  final String investorSummary;
  final String status;
  final String preferredSectors;
  final String uid;
  final String name;
  final String email;
  final String phone;

  InvestorData(
      {required this.investmentRange,
      required this.investorCompanyName,
      required this.investorIndustry,
      required this.location,
      required this.investorSummary,
      required this.preferredSectors,
      required this.status,
      required this.uid,
      required this.name,
      required this.email,
      required this.phone});

  factory InvestorData.fromMap(Map<String, String> data) {
    return InvestorData(
      investmentRange: data["investment_range"] ?? '',
      investorCompanyName: data['company_name'] ?? '',
      investorIndustry: data['investor_industry'] ?? '',
      preferredSectors: data['preferred_sector'] ?? '',
      location: data['investor_location'] ?? '',
      status: data['status'] ?? '',
      investorSummary: data['investor_summary'] ?? '',
      uid: data['user_id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'investment_range': investmentRange,
      'company_name': investorCompanyName,
      'investor_industry': investorIndustry,
      'preferred_sector': preferredSectors,
      'investor_location': location,
      'status': status,
      'investor_summary': investorSummary,
      "user_id": uid,
      'name': name,
      "email":email,
      "phone": phone,
      "business_bank": "dgjbkjbkdhgigak",
      "business_location": "Chennai",
      "looking_for": "",
      "which_type": "",
      "rupess": "20000"
    };
  }
}

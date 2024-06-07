

class UserModel {
  String password;
  String name;
  String email;
  String phoneNumber;
  String uid;


  UserModel({ required this.uid, required this.email, required this.name, required this.password, required this.phoneNumber});


Map<String, dynamic> toJson() => {
"uid": uid,
"name": name,
"email": email,
"phone_number": phoneNumber,
"bookmarked": []

};

}
class UserModel {
  final String name;
  final String id;
  final String email;
  final String phoneNumber;

  UserModel({required this.email, required this.name, required this.id, required this.phoneNumber});


  // convert a user object int a map object

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
    };
  } 


  // create a user object from a map object

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      email: map["email"], 
      name: map["name"], 
      id: map["user_id"], 
      phoneNumber: map["phone_number"]
      );
  }
}
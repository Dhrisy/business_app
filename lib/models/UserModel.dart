

// import 'package:hive/hive.dart';

// part 'UserModel.g.dart';

// @HiveType(typeId: 1)
// class UserModel {

//   @HiveField(0)
//   String name;

//   @HiveField(1)
//   String email;

//   @HiveField(2)
//   String password;

//   @HiveField(3)
//   String phoneNumber;

//   UserModel({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phoneNumber
//   });
// }


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

};

}
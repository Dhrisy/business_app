

import 'package:hive/hive.dart';

part 'UserModel.g.dart';

@HiveType(typeId: 1)
class UserModel {

  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String phoneNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber
  });
}
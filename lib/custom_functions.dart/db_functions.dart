import 'package:business_app/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

List<UserModel>  userList = [];
ValueNotifier<List<UserModel>>   userListNotifier = ValueNotifier([]);
void addUser(UserModel value)async {
  // userList.add(value);
final user_db = await  Hive.openBox<UserModel>("user_db");
await user_db.add(value);

}


Future<void> getUserDetails() async{
  final user_db = await  Hive.openBox<UserModel>("user_db");

}
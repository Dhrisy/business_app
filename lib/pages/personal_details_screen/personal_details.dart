import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key, required this.userData}) : super(key: key);
  final DocumentSnapshot userData;

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Personal details"),
                Text("edit details", style: TextStyle(fontSize: 14.sp),),
              ],
            ),
          ),
          body: Column(
            children: [
              _tileList(context, "Name", widget.userData["name"]),
              _tileList(context, "Email address", widget.userData["email"]),
              _tileList(
                  context, "Phone number", widget.userData["phone_number"]),
            ],
          ),
        ),
      ),
    );
  }

  _tileList(BuildContext context, String title, String subTite) {
    return ListTile(
      title: Text("$title"),
      subtitle: Text(subTite),
    );
  }
}

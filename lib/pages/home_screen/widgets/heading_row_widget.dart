import 'package:business_app/animation.dart';
import 'package:business_app/pages/all_business/all_business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingRowWidget extends StatelessWidget {
  final String profile;
  final List<DocumentSnapshot> profileData;
  const HeadingRowWidget({Key? key, required this.profile, required this.profileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          profile == "Business"
              ? "Businesses for Sale on SMERGERS"
              : "Investors & Business Buyers on SMERGERS",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                      page: AllBusiness(
                    profile: profile,
                    investors: [],
                  )));
            },
            child: const Text(
              "See all",
              style: TextStyle(fontWeight: FontWeight.w300),
            ))
      ],
    );
  }
}

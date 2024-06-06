import 'package:business_app/animation.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/details_screen/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({Key? key, required this.documentSnapshot,
  required this.profile,}) : super(key: key);

  final DocumentSnapshot documentSnapshot;
  final String profile;

  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
         
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140.h,
                width: 150.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: AssetImage("assets/images/default_business.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.w,
                    ),
                    Text(
                      widget.profile == "Business"
                      ? widget.documentSnapshot["business_industry"]
                      : widget.documentSnapshot["investor_industry"],
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                       widget.profile == "Business"
                      ? widget.documentSnapshot["company_name"]
                      : widget.documentSnapshot["company_name"],
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          size: 14.sp,
                        ),
                        Text(
                           widget.profile == "Business"
                      ? widget.documentSnapshot["business_location"]
                      : widget.documentSnapshot["investor_location"],
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          size: 25.sp,
                        ),
                        Text(
                          "50,0000",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () {
                     Navigator.push(context, CustomPageRoute(page: DetailsScreen(
                      title: widget.documentSnapshot["company_name"],
                       businessDetails: widget.documentSnapshot, profile: widget.profile)));
                    },
                    child: Container(
                        height: 35.h,
                        width: MediaQuery.of(context).size.width * 0.25.w,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "view",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )
          
          ],
        ),
      ),
    );
  }
}

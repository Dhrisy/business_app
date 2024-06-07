import 'package:business_app/animation.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/details_screen/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessTab extends StatefulWidget {
  const BusinessTab({Key? key}) : super(key: key);

  @override
  _BusinessTabState createState() => _BusinessTabState();
}

class _BusinessTabState extends State<BusinessTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance
                .collection('business')
                .where("user_id",
                    isEqualTo: FirebaseAuth.instance.currentUser!
                        .uid)
                .snapshots(),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('Nothing added yet'));
              }

          return Column(
            children: [
          
              Expanded(
                child: Container(
                  // height: double.infinity,
                  width: double.infinity,
                  color: backgroundColor,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _buildCard(context, snapshot.data!.docs[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 0.5.h,
                          width: double.infinity,
                          color: Color.fromARGB(255, 216, 215, 215),
                        );
                      },
                      itemCount: snapshot.data!.docs.length),
                ),
              )
            ],
          );
        }
      ),
    );
  }

  _buildCard(BuildContext context, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 180.h,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageContainer(context),
            SizedBox(width: 15.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.w,),
                    Text(document["business_industry"],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                    Text(document["company_name"],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),),
                    Row(
                      children: [
                        Icon(Icons.place, size: 14.sp,),
                        Text(document["business_location"],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee_sharp, size: 25.sp,),
                        Text("5,00,000",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                    
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, 
                      CustomPageRoute(page: DetailsScreen(
                        title: document["company_name"],
                         businessDetails: document, profile: "Business")));
                    },
                    child: Container(
                      height: 35.h,
                      width: MediaQuery.of(context).size.width*0.25.w,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("view",
                          style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400
                      ),),
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

  _imageContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140.h,
        width: 180.w,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
                image: AssetImage("assets/images/default_business.jpg"),
                fit: BoxFit.cover)),
      ),
    );
  }
}

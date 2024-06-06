import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/details_screen/widgets/images_lists.dart';
import 'package:business_app/pages/details_screen/widgets/overview_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.title,
    required this.businessDetails,
    required this.profile,
    // required this.investorDetails
  }) : super(key: key);

  final String title;
  final DocumentSnapshot businessDetails;
  final String profile;
  // final DocumentSnapshot investorDetails;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final verticalGap = SizedBox(
    height: 15.h,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(widget.businessDetails["company_name"]),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageContainer(context),
                        verticalGap,
                        SizedBox(
                          height: 5.h,
                        ),
                        OverviewWidget(
                          profile: widget.profile,
                          title: "Overview",
                          overViewData: widget.businessDetails,
                        ),
                        verticalGap,
                        widget.profile == "Business"
                            ? Container(
                                height: 35.h,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 244, 243, 243),
                                  // borderRadius: BorderRadius.circular(8.r)
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Business photographs",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 8.h,
                        ),
                        widget.profile == "Business"
                            ? ImagesLists()
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 60.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buttonConnect(context),
            ],
          ),
        ),
      ),
    );
  }

  _imageContainer(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.green,
          image: DecorationImage(
              image: AssetImage("assets/images/default_business.jpg"),
              fit: BoxFit.contain)),
    );
  }

  _buttonConnect(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.r),
              topLeft: Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.r, color: Colors.grey, offset: Offset(0, -1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _showMyDialog(context);
              },
              child: Container(
                height: 40.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Connect",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    final TextEditingController name = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController interested = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Send connection'), 
            InkWell(onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.close))],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('Name'),
                ReusableTextfield(
                  controller: name,
                ),
                Text('Phone number'),
                ReusableTextfield(
                  controller: phone,
                ),
                Text("I'm interested in"),
                ReusableTextfield(
                  controller: interested,
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          showCloseIcon: true,
                          content: Text('Sent connection'),
                        ),
                      );
                  },
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

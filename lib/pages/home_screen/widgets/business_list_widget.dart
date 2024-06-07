import 'package:business_app/animation.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/details_screen/details_screen.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessListWidget extends StatefulWidget {
  const BusinessListWidget({
    Key? key,
    required this.businessData,
    this.loggedUser,
    required this.bookamarkIds,
    required this.profile
  }) : super(key: key);

  final List<DocumentSnapshot> businessData;
  final DocumentSnapshot? loggedUser;
  final List<String> bookamarkIds;
  final String profile;
  

  @override
  _BusinessListWidgetState createState() => _BusinessListWidgetState();
}

class _BusinessListWidgetState extends State<BusinessListWidget> {
  final verticalGap = SizedBox(
    height: 5.h,
  );

  @override
  void initState() {
    super.initState();
    print('business data is ${widget.bookamarkIds}');
    print(widget.businessData[0]['business_bank']);
  }

  bool toggleBookMark = false;
  String userEmail = "";

  void setToggle(int index) {
    // toggleBookMark = !toggleBookMark;
    print(
        "object is ${widget.bookamarkIds.contains(widget.businessData[index].id)}");
    if (widget.bookamarkIds.contains(widget.businessData[index].id)) {
      setState(() {
        toggleBookMark = !toggleBookMark;
      });
    } else {
      print("vvvvvvvvvvvvvvvv");
    }
  }

  Future<String> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmail").toString();
  }

  @override
  Widget build(BuildContext context) {
    print("ddddddddddd${widget.profile}");
    return Consumer<ProfileProvider>(builder: (context, userProfile, child) {
      return Container(
        height: 300.h,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.businessData.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey, width: 0.5.w)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalGap,
                        Container(
                          height: 150.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: 
                                  widget.profile == "Business"?
                                  AssetImage(
                                      "assets/images/default_business.jpg")
                                      : widget.profile == "Investor" ?AssetImage(
                                      "assets/images/profile_pic.jpg"): AssetImage(
                                      ""),
                                  fit: BoxFit.contain)),
                        ),
                        verticalGap,
                        Text(
                          widget.profile == "Business"?
                          widget.businessData[index]['business_bank']
                          : widget.profile == "Investor"?
                          widget.businessData[index]['name']: "User name",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 82, 81, 81)),
                        ),
                        Text(
                           widget.profile == "Business"?
                          widget.businessData[index]['looking_for']
                          : widget.profile == "Investor"?
                          widget.businessData[index]['investor_industry']: "industry",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            // color: const Color.fromARGB(255, 82, 81, 81)
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                               widget.profile == "Business"?
                          widget.businessData[index]['which_type']
                          : widget.profile == "Investor"?
                          widget.businessData[index]['company_name']: "company name",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                // color: const Color.fromARGB(255, 82, 81, 81)
                              ),
                            ),
                            Text(
                               widget.profile == "Business"?
                          "₹ ${widget.businessData[index]['rupees']}"
                          : widget.profile == "Investor"?
                          "": "User name",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromARGB(255, 82, 81, 81)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _iconText(context, 
                            "Phone", Icons.phone),
                            _iconText(
                                context,
                                widget.businessData[index]['business_location'],
                                Icons.place),
                          ],
                        ),
                        verticalGap,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      page: DetailsScreen(
                                        profile: widget.profile,
                                    title: widget.businessData[index]["company_name"],
                                    businessDetails: widget.businessData[index],
                                  )));
                            },
                            child: Container(
                              height: 35.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Contact business")],
                              ),
                            ),
                          ),
                        ),
                        verticalGap,
                      ],
                    ),
                    widget.bookamarkIds
                                    .contains(widget.businessData[index].id) || toggleBookMark == false 
                                    ? Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            
                            print(toggleBookMark);
                            setToggle(index);
                            print(toggleBookMark);
                            if (!widget.bookamarkIds
                                    .contains(widget.businessData[index].id)) {
                              setBookmarkedBusiness(widget.businessData[index]);
                            } else if(widget.bookamarkIds
                                    .contains(widget.businessData[index].id)){
                              removeBookmarkedBusiness(
                                  widget.businessData[index]);
                            }
                          },
                          child: Icon(
                            widget.bookamarkIds
                                    .contains(widget.businessData[index].id)
                                ? Icons.bookmark
                                : Icons.bookmark_add_outlined,
                            color: buttonColor,
                          ),
                        )): SizedBox.shrink()
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8.w,
            );
          },
        ),
      );
    });
  }

  _iconText(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.sp,
        ),
        Text(title)
      ],
    );
  }

  Future<void> setBookmarkedBusiness(DocumentSnapshot snapshot) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bookmarked")
          .doc(snapshot.id) // This will generate a unique document ID
          .set(snapshot.data() as Map<String,
              dynamic>) // Convert DocumentSnapshot data to Map<String, dynamic>
          .then((val) {
        print("SUCCESSFULL");
      });

      final bookMarked = {
        "bookmarked": {snapshot.id}
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(bookMarked)
          .then((val) {
        print("SUCCESSFULL updation");
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> removeBookmarkedBusiness(DocumentSnapshot snapshot) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bookmarked")
          .doc(snapshot.id)
          .delete()
          .then((val) {
        print("removed SUCCESSFULL");
      });

      setState(() {
              widget.bookamarkIds.remove(snapshot.id);
              

      });
      print(widget.bookamarkIds);

    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}

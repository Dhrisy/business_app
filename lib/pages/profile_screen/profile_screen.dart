import 'dart:io';

import 'package:business_app/animation.dart';
import 'package:business_app/components/profile_card_widget.dart';
import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/create_profile_screen/create_profile_screen.dart';
import 'package:business_app/pages/my_profiles/my_profiles.dart';
import 'package:business_app/pages/personal_details_screen/personal_details.dart';
import 'package:business_app/pages/profile_screen/widgets/create_profile_button.dart';
import 'package:business_app/pages/splash_screen/splash_screen.dart';
import 'package:business_app/pages/upgrade_membership_screen/upgrade_membership_screen.dart';
import 'package:business_app/provider/bottom_navigation_provider.dart';
import 'package:business_app/provider/create_profile_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final verticalGap = SizedBox(
    height: 10.h,
  );

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  color: backgroundColor,
                  // color: Color.fromARGB(255, 252, 241, 142),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where("uid",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
      
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No users found'));
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Profile",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                        color: buttonColor),
                                  ),
                                ),
                                verticalGap,
                                Container(
                                  height: 0.5.h,
                                  width: double.infinity,
                                  color: const Color.fromARGB(255, 188, 186, 186),
                                ),
                                verticalGap,
                                _profileContainer(
                                    context, snapshot.data!.docs.first),
                                Container(
                                  height: 0.5.h,
                                  width: double.infinity,
                                  color: const Color.fromARGB(255, 188, 186, 186),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ProfileCardWidget(
                                  icon: Icons.person,
                                  title: "Personal details",
                                  callBack: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            page: PersonalDetails(
                                          userData: snapshot.data!.docs.first,
                                        )));
                                  },
                                ),
                                verticalGap,
                                ProfileCardWidget(
                                  icon: Icons.person_add_alt_1,
                                  title: "My Listing",
                                  myProfiles: true,
                                  callBack: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            page: const MyProfiles()));
                                    // profileProvider.showProfileLists();
                                    // print("provider is ${profileProvider.showProfileLists}");
                                  },
                                ),
                                profileProvider.showProfiles
                                    ? Align(
                                        child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Container(
                                          // height: 100,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.5.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 201, 200, 200))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 35.h,
                                                  width: double.infinity,
                                                  // color: Colors.green,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Business",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 0.5.h,
                                                width: double.infinity,
                                                color: const Color.fromARGB(
                                                    255, 210, 208, 208),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 35.h,
                                                  width: double.infinity,
                                                  // color: Colors.green,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Investor",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 0.5.h,
                                                width: double.infinity,
                                                color: const Color.fromARGB(
                                                    255, 210, 208, 208),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 35.h,
                                                  width: double.infinity,
                                                  // color: Colors.green,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Advisor",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                    : const SizedBox.shrink(),
                                verticalGap,
                                const ProfileCardWidget(
                                  icon: Icons.wallet,
                                  title: "Invoices",
                                ),
                                verticalGap,
                                ProfileCardWidget(
                                  icon: Icons.star,
                                  title: "Upgrade membership",
                                  callBack: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            page: UpgradeMembershipScreen()));
                                  },
                                ),
                                verticalGap,
                                ProfileCardWidget(
                                  icon: Icons.email,
                                  title: "Write us",
                                  // color: Colors.red,
                                  callBack: () {
                                    _writeDialogue(context);
                                  },
                                ),
                                verticalGap,
                                ProfileCardWidget(
                                  icon: Icons.logout,
                                  title: "Logout",
                                  color: Colors.red,
                                  callBack: () {
                                    final _auth = FirebaseAuth.instance;
                                    _showMyDialog(context);
                                  },
                                ),
                                verticalGap,
                                verticalGap
                              ],
                            );
                          });
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _writeDialogue(BuildContext context) async {
    final TextEditingController report = TextEditingController();
    final reportForm = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write us'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: reportForm,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter the query here...'),
                        SizedBox(
                          height: 15.h,
                        ),
                        ReusableTextfield(
                          hintText: "Enter query",
                          controller: report,
                          validation: (_) {
                            if (report.text == "") {
                              return "This field is required";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: buttonColor,
                  )),
              child: TextButton(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextButton(
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (reportForm.currentState!.validate()) {
                    Navigator.of(context).pop();
                    _sendEmail("ddhrisyal2000@gmail.com", "Query", report.text);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                final _auth = FirebaseAuth.instance;
                final GoogleSignIn _googleSignIn = GoogleSignIn();
                _auth.signOut();
                await _googleSignIn.signOut();
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                final bottomNavigationProvider =
                    Provider.of<BottomNavigationProvider>(context,
                        listen: false);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _profileContainer(BuildContext context, DocumentSnapshot userData) {
    return Consumer<CreateProfileProvider>(builder: (context, provider, child) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15.h,
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  provider.profilePic == null
                      ? Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: const BoxDecoration(
                            // color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/profile_pic.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(provider.profilePic!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      provider.pickImageForProfile(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text("Edit photo")],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              // flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ${userData["name"]}",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    "Email : ${userData["email"]}",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      _bottomSheet(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                            Text(
                              "Add profile",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  verticalGap,
                  Text(
                    "Select the profile you want to create",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  verticalGap,
                  CreateProfileButton(
                      title: "Create business profile",
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateProfileScreen(
                                      profile: "Business",
                                      isBusinessProfile: true,
                                      screenHeading:
                                          "Create your business profile",
                                    )));
                      }),
                  verticalGap,
                  CreateProfileButton(
                      title: "Create investor profile",
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateProfileScreen(
                                      profile: "Investor",
                                      isBusinessProfile: false,
                                      screenHeading:
                                          "Create your investor profile",
                                    )));
                      }),
                  verticalGap,
                  CreateProfileButton(
                      title: "Create advisor profile",
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateProfileScreen(
                                      profile: "Advisor",
                                      isBusinessProfile: false,
                                      screenHeading:
                                          "Create your advisor profile",
                                    )));
                      }),
                ],
              ),
            ),
          );
        });
  }

  // void _sendEmail(String email, String subject, String body) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     queryParameters: {
  //       'subject': subject,
  //       'body': body,
  //     },
  //   );

  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri, mode: LaunchMode.inAppWebView);
  //   } else {
  //     throw 'Could not launch $emailUri';
  //   }
  // }


   void _sendEmail(String email, String subject, String body) async {
    final String emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: {
        'subject': subject,
        'body': body,
      }.entries.map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}').join('&'),
    ).toString();

    if (await canLaunchUrlString(emailUri)) {
      await launchUrlString(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}

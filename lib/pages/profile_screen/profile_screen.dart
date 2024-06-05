import 'package:business_app/animation.dart';
import 'package:business_app/components/profile_card_widget.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/create_profile_screen/create_profile_screen.dart';
import 'package:business_app/pages/my_profiles/my_profiles.dart';
import 'package:business_app/pages/profile_screen/widgets/create_profile_button.dart';
import 'package:business_app/pages/splash_screen/splash_screen.dart';
import 'package:business_app/provider/bottom_navigation_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Container(
              color: backgroundColor,
              // color: Color.fromARGB(255, 252, 241, 142),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      _profileContainer(context),
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
                      ),
                      verticalGap,
                      ProfileCardWidget(
                        icon: Icons.person_add_alt_1,
                        title: "My profiles",
                        myProfiles: true,
                        callBack: () {
                          Navigator.push(context, CustomPageRoute(page: const MyProfiles()));
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
                                    MediaQuery.of(context).size.width * 0.5.w,
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
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
                                              textAlign: TextAlign.center,
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
                      const ProfileCardWidget(
                        icon: Icons.star,
                        title: "Upgrade membership",
                      ),
                      verticalGap,
                      ProfileCardWidget(
                        icon: Icons.logout,
                        title: "Logout",
                        color: Colors.red,
                        callBack: () {
                          final bottomNavigationProvider =
                              Provider.of<BottomNavigationProvider>(context,
                                  listen: false);
                          bottomNavigationProvider.changeIndex(0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                          );
                        },
                      ),
                      verticalGap,
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _profileContainer(BuildContext context) {
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
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/profile_pic.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 18.sp,
                      ),
                      const Text("Edit")
                    ],
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
                  "Name : User",
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  "Email : user@gmail.com",
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
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
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
                    action: (){
                      Navigator.pop(context);
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const CreateProfileScreen(
                          profile: "Business",
                          isBusinessProfile: true,
                          screenHeading: "Create your business profile",
                          )));
                    }),
                    verticalGap,
                     CreateProfileButton(
                    title: "Create investor profile", 
                    action: (){
                      Navigator.pop(context);
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const CreateProfileScreen(
                          profile: "Investor",
                          isBusinessProfile: false,
                          screenHeading: "Create your investor profile",
                          )));

                    }),
                    verticalGap,
                     CreateProfileButton(
                    title: "Create advisor profile", 
                    action: (){
                      Navigator.pop(context);
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const CreateProfileScreen(
                          profile: "Advisor",
                          isBusinessProfile: false,
                          screenHeading: "Create your advisor profile",
                          )));

                    }),
],
              ),
            ),
          );
        });
  }

 
}

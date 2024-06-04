import 'package:business_app/constants.dart';
import 'package:business_app/pages/bookmark_screen/bookmark_screen.dart';
import 'package:business_app/pages/home_screen/home_screen.dart';
import 'package:business_app/pages/notification/notification_screen.dart';
import 'package:business_app/pages/profile_screen/profile_screen.dart';
import 'package:business_app/provider/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List screens = const [
    HomeScreen(),
     BookmarkScreen(),
    NotificationScreen(),
   
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return Material(
        child: Consumer<BottomNavigationProvider>(
          builder: (context, bottomProvider, child) {
            return Scaffold(
                  body: screens[bottomProvider.currentIndex],
                  bottomNavigationBar: _bottomNavigationBar(context),
                );
          }
        ));
  }

  _bottomNavigationBar(BuildContext context) {
    return Container(
      height: 45.h,
      width: double.infinity,
      color: const Color.fromARGB(255, 209, 208, 208),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Consumer<BottomNavigationProvider>(
            builder: (context, bottomProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  bottomProvider.changeIndex(0);
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.home,
                    size: 32.sp,
                    color: bottomProvider.currentIndex == 0 ? buttonColor : const Color.fromARGB(255, 59, 58, 58),
                    )
                    ],
                ),
              ),
              InkWell(
                onTap: () {
                  bottomProvider.changeIndex(1);
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark,
                    size: 32.sp,
                    color: bottomProvider.currentIndex == 1 ? buttonColor : const Color.fromARGB(255, 59, 58, 58),
                    )
                    ],
                ),
              ),
              InkWell(
                onTap: () {
                  bottomProvider.changeIndex(2);
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications,
                    size: 32.sp,
                    color: bottomProvider.currentIndex == 2 ? buttonColor : const Color.fromARGB(255, 59, 58, 58),
                    )
                    ],
                ),
              ),
              InkWell(
                onTap: () {
                  bottomProvider.changeIndex(3);
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person,
                    size: 32.sp,
                    color: bottomProvider.currentIndex == 3 ? buttonColor : const Color.fromARGB(255, 59, 58, 58),
                    )
                    ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }


}

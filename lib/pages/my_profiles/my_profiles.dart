import 'package:business_app/pages/my_profiles/widgets/business_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfiles extends StatefulWidget {
  const MyProfiles({Key? key}) : super(key: key);

  @override
  _MyProfilesState createState() => _MyProfilesState();
}

class _MyProfilesState extends State<MyProfiles> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("My profiles", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: const DefaultTabController(
            length: 3, 
            
            child: Column(
              children: [
                TabBar(
                  
                  tabs: [
                    Tab( text: "Business"),
                    Tab(text: "Investor"),
                    Tab( text: "Advisor"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                     BusinessTab(),
                      Center(child: Text("Tab 2")),
                      Center(child: Text("Tab 3")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


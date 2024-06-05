import 'package:flutter/material.dart';

class MyProfiles extends StatefulWidget {
  const MyProfiles({Key? key}) : super(key: key);

  @override
  _MyProfilesState createState() => _MyProfilesState();
}

class _MyProfilesState extends State<MyProfiles> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SafeArea(
        child: Scaffold(
          body: DefaultTabController(
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
                      Center(child: Text("Tab 1")),
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


import 'package:business_app/pages/home_screen/widgets/business_list_widget.dart';
import 'package:business_app/pages/home_screen/widgets/heading_row_widget.dart';
import 'package:business_app/provider/business_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DocumentSnapshot> businessData = [];

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            child: Scaffold(
      drawer: Container(
        width: 200.w,
        height: double.infinity,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: () {}, child: const Icon(Icons.menu)),
        title: const Text("Smergers india"),
      ),
      body: Consumer<ProfileProvider>(
          builder: (context, userProfileProvider, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where("uid",
                    isEqualTo: FirebaseAuth.instance.currentUser!
                        .uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No users found'));
              }

              var userDoc = snapshot.data!.docs.first;
              print("name is ${userDoc["name"]}");
          List<String> bookmarkedIds = List<String>.from(userDoc['bookmarked'] ?? []);



              return SingleChildScrollView(
                child: Column(
                  children: [
                     _businessListConatiner(context, bookmarkedIds),
                     _investorListContainer(context)
                  ],
                ),
              );
            });
      }),
    )));
  }


  _investorListContainer(BuildContext context){
    print("ooooooo");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("investors").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No users found'));
            }

            print("kkkkkkkkkkkkk${snapshot.data!.docs.length}");

            return Column(
              children: [
                HeadingRowWidget(
                  profileData: snapshot.data!.docs,
                  profile: "Investor",
                ),
                BusinessListWidget(
                  profile: "Investor",
                  businessData: snapshot.data!.docs,
                  bookamarkIds: [],
                )
              ],
            );
          }),
    );
  }

  _businessListConatiner(BuildContext context, List<String> bookmarkedId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("business").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No users found'));
            }

            return Column(
              children: [
                HeadingRowWidget(
                  profileData: snapshot.data!.docs,
                  profile: "Business",
                ),
                BusinessListWidget(
                  profile: "Business",
                  businessData: snapshot.data!.docs,
                  bookamarkIds: bookmarkedId,
                )
              ],
            );
          }),
    );
  }

  Future<void> isBookMarked() async {
    print("nnnnnnnn");
    final businessProvider = Provider.of<BusinessProvider>(context);

    // final allBusiness = businessProvider.selectedBusiness;

    FirebaseFirestore.instance.collection('business').get().then((snapshot) {
      businessProvider.setSelectedBusiness(snapshot.docs);
    });

    // Fetch bookmarked businesses
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookmarked')
        .snapshots()
        .listen((snapshot) {
      businessProvider.setBookmarkedBusinesses(snapshot.docs);
    });

    print(
        "${businessProvider.bookmarkedBusinesses.length},  ${businessProvider.selectedBusiness.length}");
  }

  void loadBusinessFunction() async {
    final provider = Provider.of<ProfileProvider>(context);
    await provider.loadBusinessProfiles();
    print(provider.businessProfiles[0]);
  }
}

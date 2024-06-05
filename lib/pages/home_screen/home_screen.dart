import 'package:business_app/pages/home_screen/widgets/business_list_widget.dart';
import 'package:business_app/pages/home_screen/widgets/heading_row_widget.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
print("llllllllll");
// loadBusinessFunction();
    
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProfileProvider>(context);
    // provider.loadBusinessProfiles();
    // print(provider.businessProfiles[0]);
    return Material(
        child: SafeArea(
            child: Scaffold(
      drawer: Container(
        width: 200.w,
        height: double.infinity,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        title: Text("Smergers india"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
        .doc(_auth.currentUser!.uid).collection("business").snapshots(),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found'));
          }

          var users = snapshot.data!.docs;

          print("DATA IS: ${users.length}");


          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                HeadingRowWidget(
                ), 
                BusinessListWidget()],
            ),
          );
        }
      ),
    )));
  }


  void loadBusinessFunction() async{
    final provider = Provider.of<ProfileProvider>(context);
    await provider.loadBusinessProfiles();
    print(provider.businessProfiles[0]);
  }
}

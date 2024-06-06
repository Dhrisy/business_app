import 'dart:ffi';

import 'package:business_app/components/business_card.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/custom_functions/custom_functions.dart';
import 'package:business_app/models/investor_data.dart';
import 'package:business_app/pages/home_screen/widgets/business_list_widget.dart';
import 'package:business_app/provider/bottom_navigation_provider.dart';
import 'package:business_app/provider/search_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllBusiness extends StatefulWidget {
  const AllBusiness({Key? key, required this.investors,
  required this.profile}) : super(key: key);

  final List<DocumentSnapshot> investors;
  final String profile;

  @override
  _AllBusinessState createState() => _AllBusinessState();
}

class _AllBusinessState extends State<AllBusiness> {
  final TextEditingController searchBar = TextEditingController();

  bool searchValue = false;
  List<InvestorData> investors = [];
  bool isLoading = true;

 


  void fetchInvestors() async {
    List<InvestorData> fetchedInvestors = await getInvestors();
    setState(() {
      investors = fetchedInvestors;
      isLoading = false;
    });

    print("fffffffffffff${investors[0]}");
  }



  Future<List<InvestorData>> getInvestors() async {
  try {
    final investorSnapshot = await FirebaseFirestore.instance
        .collection("investors")
        .get();

    final investors = investorSnapshot.docs
        .map((doc) => InvestorData.fromMap(doc as Map<String, String>))
        .toList();

    return investors;
  } catch (e) {
    print('Error fetching investors: $e');
    return [];
  }
}
  @override
  Widget build(BuildContext context) {
    final collection = widget.profile == "Business" ? "business" : "investors";
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Search"),
            automaticallyImplyLeading: true,
          ),
          backgroundColor: backgroundColor,
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collection)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No users found'));
                  }


                  // final investorSnapshot = fetchInvestors();
                  // print("ttttttttttttt${investors[0]}");
                  

                  final filteredDocumnets = snapshot.data!.docs.toList();

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<SearchProvider>(
                          builder: (context, searchProvider, child) {
                        return Column(
                          children: [
                            TextFormField(
                              controller: searchBar,
                              autofocus: false,
                              
                              onChanged: (val){
                                searchProvider.setSearchResults(true);
                                
                              },
                              decoration: InputDecoration(
                                hintText: "Search based on location...",
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot.data!.docs.length);

                                    final filteredDocumnets =
                                        snapshot.data!.docs.toList();
                                    final listVieProfileRecord =
                                        filteredDocumnets[index];

                                    

                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (CustomFunctions().search(
                                                searchBar.text,
                                                listVieProfileRecord[
                                                    "business_location"]) ??
                                            true)
                                          BusinessCard(
                                            profile: widget.profile,
                                            documentSnapshot: snapshot.data!.docs[index],
                                          ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }));
                })),
      ),
    );
  }
}

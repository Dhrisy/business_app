import 'package:business_app/pages/home_screen/widgets/business_list_widget.dart';
import 'package:business_app/pages/home_screen/widgets/heading_row_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusinessListContainer extends StatefulWidget {
  const BusinessListContainer({ Key? key, required this.bookMarkedIds }) : super(key: key);

  final List<String> bookMarkedIds;

  @override
  _BusinessListContainerState createState() => _BusinessListContainerState();
}

class _BusinessListContainerState extends State<BusinessListContainer> {
  @override
  Widget build(BuildContext context) {
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
                  profile: "Business",
                  profileData: snapshot.data!.docs,
                ),
                BusinessListWidget(
                  profile: "Business",
                  businessData: snapshot.data!.docs,
                  bookamarkIds: widget.bookMarkedIds,
                )
              ],
            );
          }),
    );
  }
}
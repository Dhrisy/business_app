import 'package:flutter/material.dart';

class UpgradeMembershipScreen extends StatefulWidget {
  const UpgradeMembershipScreen({ Key? key }) : super(key: key);

  @override
  _UpgradeMembershipScreenState createState() => _UpgradeMembershipScreenState();
}

class _UpgradeMembershipScreenState extends State<UpgradeMembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
          ),
          body: Center(
            child: Text("Upgrade membership"),
            
          ),
        ),
      ),
    );
  }
}
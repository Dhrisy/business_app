import 'package:business_app/components/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessCardWidget extends StatefulWidget {
  const BusinessCardWidget({ Key? key }) : super(key: key);

  @override
  _BusinessCardWidgetState createState() => _BusinessCardWidgetState();
}

class _BusinessCardWidgetState extends State<BusinessCardWidget> {
    final verticalGap =  SizedBox(height: 5.h,);
    final TextEditingController businessName = TextEditingController();
    final TextEditingController businessWebsite = TextEditingController();
    final TextEditingController businessBank = TextEditingController();
    final TextEditingController businessNmae = TextEditingController();
    final TextEditingController businessLocation = TextEditingController();
    final TextEditingController businessIndustry = TextEditingController();
    final TextEditingController businessEstablishedYear = TextEditingController();
    final TextEditingController businessNumberOfEmployees = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
              SizedBox(height: 15.h,),
        
            Text("Business profile"),
            verticalGap,
            Text("Information entered here is displayed publicly to match you with the right set of investors and buyers"),
            verticalGap,
            Text("Name of the business"),
            verticalGap,
            ReusableTextfield(
              controller: businessName,
        
              ),
            verticalGap,
            Text("Business website"),
            verticalGap,
            ReusableTextfield(controller: businessWebsite),
            verticalGap,
            Text("Who do you bank with"),
            verticalGap,
            ReusableTextfield(controller: businessBank),
            verticalGap,
        
            Text("Basic Information"),
            verticalGap,
            Text("Location"),
            verticalGap,
            ReusableTextfield(controller: businessLocation),
            verticalGap,
            Text("Business Industry"),
            verticalGap,
            ReusableTextfield(controller: businessIndustry),
            verticalGap,
            Text("Year Established"),
            verticalGap,
            ReusableTextfield(controller: businessEstablishedYear),
            verticalGap,
            Text("Number of employees"),
            verticalGap,
            ReusableTextfield(controller: businessNumberOfEmployees),
            
        
          ],
        ),
      ),
    );
  }
}
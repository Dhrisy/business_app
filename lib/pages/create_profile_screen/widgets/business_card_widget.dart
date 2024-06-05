import 'package:business_app/components/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessCardWidget extends StatefulWidget {
  const BusinessCardWidget({
    Key? key,
    required this.businessBank,
    required this.businessEstablishedYear,
    required this.businessIndustry,
    required this.businessLocation,
    required this.businessName,
    required this.businessNumberOfEmployees,
    required this.businessWebsite,
    required this.formKey,
  }) : super(key: key);
  final TextEditingController businessName;
  final TextEditingController businessWebsite;
  final TextEditingController businessBank;
  final TextEditingController businessLocation;
  final TextEditingController businessIndustry;
  final TextEditingController businessEstablishedYear;
  final TextEditingController businessNumberOfEmployees;
  final GlobalKey<FormState> formKey;

  @override
  _BusinessCardWidgetState createState() => _BusinessCardWidgetState();
}

class _BusinessCardWidgetState extends State<BusinessCardWidget> {
  final verticalGap = SizedBox(
    height: 5.h,
  );
  // final TextEditingController businessName = TextEditingController();
  // final TextEditingController businessWebsite = TextEditingController();
  // final TextEditingController businessBank = TextEditingController();
  // final TextEditingController businessNmae = TextEditingController();
  // final TextEditingController businessLocation = TextEditingController();
  // final TextEditingController businessIndustry = TextEditingController();
  // final TextEditingController businessEstablishedYear = TextEditingController();
  // final TextEditingController businessNumberOfEmployees = TextEditingController();

  final textStyle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Business profile",
                style: textStyle,
              ),
              verticalGap,
              const Text(
                "Information entered here is displayed publicly to match you with the right set of investors and buyers",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              verticalGap,
              Text(
                "Name of the business",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessName,
                validation: (_) {
                  if (widget.businessName.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              verticalGap,
              Text(
                "Business website",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessWebsite,
                validation: (_) {
                  if (widget.businessWebsite.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              verticalGap,
              Text(
                "Who do you bank with",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessBank,
                validation: (_) {
                  if (widget.businessBank.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              verticalGap,
              verticalGap,
              Text(
                "Basic Information",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              verticalGap,
              Text(
                "Location",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                  validation: (_) {
                    if (widget.businessLocation.text == "") {
                      return "This field is required";
                    }
                    return null;
                  },
                  controller: widget.businessLocation),
              verticalGap,
              Text(
                "Business Industry",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessIndustry,
                validation: (_) {
                  if (widget.businessIndustry.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              verticalGap,
              Text(
                "Year Established",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessEstablishedYear,
                validation: (_) {
                  if (widget.businessEstablishedYear.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              verticalGap,
              Text(
                "Number of employees",
                style: textStyle,
              ),
              verticalGap,
              ReusableTextfield(
                controller: widget.businessNumberOfEmployees,
                validation: (_) {
                  if (widget.businessNumberOfEmployees.text == "") {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

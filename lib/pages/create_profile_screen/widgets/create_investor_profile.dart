import 'package:business_app/components/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateInvestorProfile extends StatefulWidget {
  const CreateInvestorProfile({ Key? key ,
  //  required this.businessBank,
  // required this.investi,
  required this.investorCompanyName,
  required this.investorIndustry,
  required this.investorInvestmentRange,
  required this.investorLocation,
  required this.investorStatus,
  required this.investorSummary,
  required this.investorSectorPreferred,
  required this.formKey,
  }) : super(key: key);

  // final TextEditingController investorName;
  final TextEditingController investorCompanyName; 
  final TextEditingController investorIndustry;
  final TextEditingController investorInvestmentRange;
  final TextEditingController investorLocation;
  final TextEditingController investorStatus;
  final TextEditingController investorSummary;
  final TextEditingController investorSectorPreferred;
  final GlobalKey<FormState> formKey;

  @override
  _CreateInvestorProfileState createState() => _CreateInvestorProfileState();
}

class _CreateInvestorProfileState extends State<CreateInvestorProfile> {

  final verticalGap =  SizedBox(height: 5.h,);
  final textStyle = TextStyle(
  fontSize: 14.sp
  ,fontWeight: FontWeight.normal
);
  @override
  Widget build(BuildContext context) {
      return Container(
      // height: 200.h,
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
          
              Text("Investor profile", style: textStyle,),
              verticalGap,
              const Text("Information entered here is displayed publicly to match you with the right set of business",
              style: TextStyle(
                fontWeight: FontWeight.w300
              ),),
              verticalGap,
              Text("Company name",  style: textStyle,),
              verticalGap,
              ReusableTextfield(
                controller: widget.investorCompanyName,
                validation: (_){
                  if(widget.investorCompanyName.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
          
                ),
              verticalGap,
              Text("Business industry", style: textStyle,),
              verticalGap,
              ReusableTextfield(
                controller: widget.investorIndustry,
                validation: (_){
                  if(widget.investorIndustry.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                ),
              verticalGap,
              Text("Investment range",  style: textStyle,),
              verticalGap,
              ReusableTextfield(
                controller: widget.investorInvestmentRange,
                validation: (_){
                  if(widget.investorInvestmentRange.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                ),
              verticalGap,
              verticalGap,
          
              
              Text("Location",  style: textStyle,),
              verticalGap,
              ReusableTextfield(
                validation: (_){
                  if(widget.investorLocation.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                controller: widget.investorLocation),
              verticalGap,
              Text("Profile summary",  style: textStyle,),
              verticalGap,

              
              ReusableTextfield(controller: widget.investorSummary,
              validation: (_){
                  if(widget.investorSummary.text == ""){
                    return "This field is required";
                  }
                  return null;
                },),
              verticalGap,
              Text("Your status either active or inactive",  style: textStyle,),
              verticalGap,
              ReusableTextfield(controller: widget.investorStatus,
              validation: (_){
                  if(widget.investorStatus.text == ""){
                    return "This field is required";
                  }
                  return null;
                },),
              verticalGap,
              Text("Enter the sectors you prefer",  style: textStyle,),
              verticalGap,
              ReusableTextfield(controller: widget.investorSectorPreferred,
              validation: (_){
                  if(widget.investorSectorPreferred.text == ""){
                    return "This field is required";
                  }
                  return null;
                },),
              
          
            ],
          ),
        ),
      ),
    );
  
  }
}
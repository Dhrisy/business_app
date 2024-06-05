import 'package:business_app/components/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfidenticailCardWidget extends StatefulWidget {
  const ConfidenticailCardWidget({Key? key,
  required this.email,
  required this.name,
  required this.phone,
  required this.formKey,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final GlobalKey<FormState> formKey;

  @override
  _ConfidenticailCardWidgetState createState() =>
      _ConfidenticailCardWidgetState();
}

class _ConfidenticailCardWidgetState extends State<ConfidenticailCardWidget> {
  final confidentialForm = GlobalKey<FormState>();


  final verticalGap =  SizedBox(height: 5.h,);
  
final textStyle = TextStyle(
  fontSize: 14.sp
  ,fontWeight: FontWeight.normal
);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text("Confidential Information",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),),
                verticalGap,
                const Text("Enter your own details here. Information entered here is not publicly displyed",
                style: TextStyle(
                  fontWeight: FontWeight.w300
                ),),
                verticalGap,
                Text("Your name", style: textStyle,),
                verticalGap,
                ReusableTextfield(controller: widget.name,
                validation: (_){
                  if(widget.name.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                ),
                verticalGap,
                Text("Your email", style: textStyle,),
                verticalGap,
                ReusableTextfield(controller: widget.email,
                validation: (_){
                  if(widget.email.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                ),
                verticalGap,
                Text("Your phone number", style: textStyle,),
                verticalGap,
                ReusableTextfield(controller: widget.phone,
                validation: (_){
                  if(widget.phone.text == ""){
                    return "This field is required";
                  }
                  return null;
                },
                ),
                SizedBox(height: 15.h,)
              ],
            ),
          )),
    );
  }
}

import 'package:business_app/components/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfidenticailCardWidget extends StatefulWidget {
  const ConfidenticailCardWidget({Key? key}) : super(key: key);

  @override
  _ConfidenticailCardWidgetState createState() =>
      _ConfidenticailCardWidgetState();
}

class _ConfidenticailCardWidgetState extends State<ConfidenticailCardWidget> {
  final confidentialForm = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController officialEmail = TextEditingController();


  final verticalGap =  SizedBox(height: 5.h,);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: double.infinity,
      color: Colors.red,
      child: Form(
          key: confidentialForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h,),
                Text("Confidential Information"),
                verticalGap,
                Text(" enter your own details here. Information entered here is not publicly displyed"),
                verticalGap,
                Text("Your name"),
                verticalGap,
                ReusableTextfield(controller: name),
                verticalGap,
                Text("Your email"),
                verticalGap,
                ReusableTextfield(controller: name),
                verticalGap,
                Text("Your phone number"),
                verticalGap,
                ReusableTextfield(controller: name),
                SizedBox(height: 15.h,)
              ],
            ),
          )),
    );
  }
}

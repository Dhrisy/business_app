import 'package:business_app/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({ Key? key,
  this.icon,
  this.title,
  this.color,
  this.isAddedProfile,
  this.callBack,
  this.myProfiles,
   }) : super(key: key);

  final IconData? icon;
  final String? title;
  final Color? color;
  final bool? isAddedProfile;
  final VoidCallback? callBack;
  final bool? myProfiles;

  @override
  _ProfileCardWidgetState createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {

  var dropdownList = ["Business", "Investor", "Advisor"];
  String dropDownValue = "Business";
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return InkWell(
          onTap: widget.callBack,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const[
                BoxShadow(
                  blurRadius: 4,
                  color: const Color.fromARGB(255, 188, 187, 187),
                  offset: Offset(1, 0))
              ]
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                  Icon(widget.icon, color: widget.color,),
                  SizedBox(width: 10.w,),
                  Text(widget.title.toString(), style: TextStyle(
                    fontSize: 14.sp, color: widget.color),),
          
                    
          
                    // widget.isAddedProfile == true ? 
                    // DropdownButton(
                    //   value: dropDownValue,
                    //   items: dropdownList.map((String items)), 
                    // onChanged: onChanged): SizedBox.shrink()
                ],),
              ),
            ),
            
          ),
        );
      }
    );
  }
}
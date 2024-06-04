import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileButton extends StatelessWidget {
const CreateProfileButton({ Key? key,
required this.title,
required this.action,
 }) : super(key: key);

final String title;
final VoidCallback action;
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: action,
      child: Container(
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 175, 108),
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              )
            ],
          )),
    );
  }
}
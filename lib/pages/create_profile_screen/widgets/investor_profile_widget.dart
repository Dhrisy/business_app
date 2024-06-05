import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvestorProfileWidget extends StatefulWidget {
  const InvestorProfileWidget({ Key? key }) : super(key: key);

  @override
  _InvestorProfileWidgetState createState() => _InvestorProfileWidgetState();
}

class _InvestorProfileWidgetState extends State<InvestorProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
    height: 100.h,
    width: 100.w,
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
      image: DecorationImage(image: AssetImage("assets/images/profile_pic.jpg"))
    ),
    );
  }
}
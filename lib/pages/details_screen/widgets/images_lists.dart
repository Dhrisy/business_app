import 'package:business_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagesLists extends StatelessWidget {
  const ImagesLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: AssetImage("assets/images/default_business.jpg"),
                      fit: BoxFit.cover)),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.w,
            );
          },
          itemCount: 5),
    );
  }
}

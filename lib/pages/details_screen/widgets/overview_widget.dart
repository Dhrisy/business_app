import 'package:business_app/constants.dart';
import 'package:business_app/custom_functions.dart/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewWidget extends StatelessWidget {
  final String title;
  OverviewWidget({Key? key, required this.title}) : super(key: key);

  final verticalGap = SizedBox(
    height: 15.h,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 300,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                            color: Color.fromARGB(255, 244, 243, 243),
                            // borderRadius: BorderRadius.circular(8.r)
                          ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(title, style: TextStyle(fontSize: 16.sp),),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      _eachRow(context, "summary",
                          "summary of the company and the company details"),
                      verticalGap,
                      _eachRow(context, "Industry", "Textiles"),
                      verticalGap,
                      _eachRow(context, "Established year", "2011"),
                      verticalGap,
                      _eachRow(context, "Number of Employees", "10-50"),
                      verticalGap,
                      _eachRow(context, "Website", "sdfghjk"),
                      verticalGap,
                      _eachRow(context, "Overview",
                          "summary of the company and the company details"),
                      verticalGap,
                      _eachRow(context, "Location", "Location"),
                      verticalGap,
                      _eachRow(context, "Looking for", "Lokking for"),
                          
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _eachRow(BuildContext context, String title, String subText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          CustomFunctions().capitalizeFirstLetter(title),
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        )),
        Text(
          ":",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
            flex: 2,
            child: Text(
              CustomFunctions().capitalizeFirstLetter(subText),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            )),
      ],
    );
  }
}

import 'package:business_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessListWidget extends StatefulWidget {
   
  const BusinessListWidget({Key? key}) : super(key: key);

  @override
  _BusinessListWidgetState createState() => _BusinessListWidgetState();
}

class _BusinessListWidgetState extends State<BusinessListWidget> {
  final verticalGap = SizedBox(
    height: 5.h,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey, width: 0.5.w)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalGap,
                        Container(
                          height: 150.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/default_business.jpg"),
                                  fit: BoxFit.contain)),
                        ),
                        verticalGap,
                        Text(
                          "Industry",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 82, 81, 81)),
                        ),
                        Text(
                          "Lookinguuuuuuuuuuuuuuuuu for",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            // color: const Color.fromARGB(255, 82, 81, 81)
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Which type",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                // color: const Color.fromARGB(255, 82, 81, 81)
                              ),
                            ),
                            Text(
                              "₹ Price",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromARGB(255, 82, 81, 81)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_iconText(context), Text("location")],
                        ),
                        verticalGap,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 35.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Contact business")],
                            ),
                          ),
                        ),
                        verticalGap,
                      ],
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.bookmark_add_outlined,
                          color: buttonColor,
                        ))
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8.w,
            );
          },
          itemCount: 3),
    );
  }

  _iconText(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.phone,
          size: 14.sp,
        ),
        Text("phone")
      ],
    );
  }
}

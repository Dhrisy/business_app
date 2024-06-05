import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingRowWidget extends StatelessWidget {
const HeadingRowWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Businesses for Sale on SMERGERS",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  ),),

                  TextButton(onPressed: (){

                  }, child: const Text("See all", style: TextStyle(fontWeight: FontWeight.w300),))
                ],
              );
  }
}
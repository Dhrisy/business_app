import 'dart:io';

import 'package:business_app/constants.dart';
import 'package:business_app/provider/create_profile_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadMediaWidget extends StatefulWidget {
  const UploadMediaWidget({Key? key}) : super(key: key);

  @override
  _UploadMediaWidgetState createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  final verticalGap = SizedBox(height: 5.h);
  String? _filePath;



  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProfileProvider>(
      builder: (context, profileProvider, child) {
        return Container(
          // height: 200,
          width: double.infinity,
          // color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Business Photographs",
                  style: TextStyle(fontSize: 16.sp),
                ),
                verticalGap,
                RichText(
                    text: TextSpan(
                        text: "Real pictures of the business ",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                        children: [
                      TextSpan(
                        text: "increases visibility by 40% ",
                        style:
                            TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "for your oppurtunity with investors/buyers",
                        style:
                            TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                      ),
                    ])),
                verticalGap,
                Container(
                  width: double.infinity,
                  height: 0.4,
                  color: const Color.fromARGB(255, 190, 189, 189),
                ),
                verticalGap,
                Text("Add Photos (upload jpg, png, gif, bmp files which are less than 5 MB in size)",
                style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300
              ),
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        // profileProvider.pickImageFromCamera(context);
                        final filePath = profileProvider.filePath;
                        profileProvider.saveImageFilePath(filePath.toString());
        
                      },
                      child: Container(
                        height: 35.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Add photos")],
                        ),
                      ),
                    ),

                    // Image.file(profileProvider.selectImage!) ,

        
                    Container(
                      height: 200,
                      width: 200,
                      child: profileProvider.selectImage != null
                      ? Image.file(profileProvider.selectImage!) 
                      : Text("No image"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  
}

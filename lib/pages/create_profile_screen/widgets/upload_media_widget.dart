
import 'package:business_app/constants.dart';
import 'package:business_app/provider/create_profile_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "for your oppurtunity with investors/buyers",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w300),
                    ),
                  ])),
              verticalGap,
              Container(
                width: double.infinity,
                height: 0.4.h,
                color: const Color.fromARGB(255, 190, 189, 189),
              ),
              verticalGap,
              Text(
                "Add Photos (upload jpg, png, gif, bmp files which are less than 5 MB in size)",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
              ),

              verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      profileProvider.pickImageFromCamera(context);
                     
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
                ],
              ),
verticalGap,
              verticalGap,
               profileProvider.images.isEmpty 
               ? const SizedBox.shrink(): SizedBox(
                    height: 200,
                    width: double.infinity,
                    // color: Colors.red,
                    child: _buildImageGrid(profileProvider),
                    ),


                    
            ],
          ),
        ),
      );
    });
  }

 

  Widget _buildImageGrid(CreateProfileProvider profileProvider) {
    return ListView.separated(
      scrollDirection: Axis.horizontal, // Set the direction to horizontal
      itemCount: profileProvider.images.length,
      itemBuilder: (context, index) {
        print("ppppp");
        print(profileProvider.images);
        return Consumer<CreateProfileProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Container(
                  height: 200,
                  width: 170,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: FileImage(profileProvider.images[index], 
                      ), fit: BoxFit.cover)
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      debugPrint("${provider.images}");
                      debugPrint("lllll");
                      provider.deleteImage(index);
                      debugPrint("${provider.images}");
                    },
                    child: const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Icon(Icons.close),
                    ))),
              ],
            );
          }
        );
      },
      separatorBuilder: (context, index){
        return SizedBox(width: 10.w,);
      },
    );
  }
}

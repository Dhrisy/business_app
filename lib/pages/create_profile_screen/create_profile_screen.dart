import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/pages/create_profile_screen/widgets/business_card_widget.dart';
import 'package:business_app/pages/create_profile_screen/widgets/confidenticail_card_widget.dart';
import 'package:business_app/pages/create_profile_screen/widgets/upload_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    Key? key,
    this.screenHeading,
    required this.isBusinessProfile,
  }) : super(key: key);

  final String? screenHeading;
  final bool isBusinessProfile;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final confidentialForm = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController officialEmail = TextEditingController();

  final verticalGap =  SizedBox(height: 15.h,);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.screenHeading.toString()),
                        ConfidenticailCardWidget(),
                        verticalGap,
                        BusinessCardWidget(),
                        verticalGap,
                        UploadMediaWidget()
                      ],
                    ),
                  ),
                ),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: 80,
                //     width: 200,
                //     color: Colors.yellow,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

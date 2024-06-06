import 'package:business_app/animation.dart';
import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/models/business_data.dart';
import 'package:business_app/pages/create_profile_screen/widgets/business_card_widget.dart';
import 'package:business_app/pages/create_profile_screen/widgets/confidenticail_card_widget.dart';
import 'package:business_app/pages/create_profile_screen/widgets/create_investor_profile.dart';
import 'package:business_app/pages/create_profile_screen/widgets/investor_profile_widget.dart';
import 'package:business_app/pages/create_profile_screen/widgets/upload_media_widget.dart';
import 'package:business_app/pages/profile_screen/profile_screen.dart';
import 'package:business_app/provider/bottom_navigation_provider.dart';
import 'package:business_app/provider/create_profile_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:business_app/shared_preference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    Key? key,
    this.screenHeading,
    required this.isBusinessProfile,
    required this.profile,
  }) : super(key: key);

  final String? screenHeading;
  final bool isBusinessProfile;
  final String profile;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final confidentialForm = GlobalKey<FormState>();
  final businessForm = GlobalKey<FormState>();
  final investorForm = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController officialEmail = TextEditingController();
  final TextEditingController phone = TextEditingController();

// business
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessWebsite = TextEditingController();
  final TextEditingController businessBank = TextEditingController();
  // final TextEditingController businessName = TextEditingController();
  final TextEditingController businessLocation = TextEditingController();
  final TextEditingController businessIndustry = TextEditingController();
  final TextEditingController businessEstablishedYear = TextEditingController();
  final TextEditingController businessNumberOfEmployees =
      TextEditingController();
  final TextEditingController businessLookingFor = TextEditingController();
  final TextEditingController whichType = TextEditingController();

  // investor
  final TextEditingController investorName = TextEditingController();
  final TextEditingController investorIndustry = TextEditingController();
  final TextEditingController investorCompanyName = TextEditingController();
  // final TextEditingController businessName = TextEditingController();
  final TextEditingController investorLocation = TextEditingController();
  final TextEditingController investorStatus = TextEditingController();
  final TextEditingController investorSectorPreference =
      TextEditingController();
  final TextEditingController investmentRange = TextEditingController();
  final TextEditingController investorSummary = TextEditingController();

  final verticalGap = SizedBox(
    height: 15.h,
  );
  bool _isInitialized = false;

  void initState() {
    super.initState();
    print("profile is ${widget.profile}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CreateProfileProvider>(context, listen: false)
        .initializeProvider();
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              title: Text(
                widget.screenHeading.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.profile == "Investor"
                            ? const InvestorProfileWidget()
                            : const SizedBox.shrink(),
                        ConfidenticailCardWidget(
                          formKey: confidentialForm,
                          email: officialEmail,
                          name: name,
                          phone: phone,
                        ),
                        verticalGap,
                        widget.profile == "Business"
                            ? BusinessCardWidget(
                                buisnessLookingFor: businessLookingFor,
                                formKey: businessForm,
                                whichType: whichType,
                                businessBank: businessBank,
                                businessEstablishedYear:
                                    businessEstablishedYear,
                                businessIndustry: businessIndustry,
                                businessLocation: businessLocation,
                                businessName: businessName,
                                businessNumberOfEmployees:
                                    businessNumberOfEmployees,
                                businessWebsite: businessWebsite,
                              )
                            : widget.profile == "Investor"
                                ? CreateInvestorProfile(
                                    formKey: investorForm,
                                    investorSectorPreferred:
                                        investorSectorPreference,
                                    investorCompanyName: investorCompanyName,
                                    investorIndustry: investorIndustry,
                                    investorInvestmentRange: investmentRange,
                                    investorLocation: investorLocation,
                                    investorStatus: investorStatus,
                                    investorSummary: investorSummary,
                                  )
                                : SizedBox.shrink(),
                        verticalGap,
                        widget.profile == "Business"
                            ? const UploadMediaWidget()
                            : widget.profile == "Investor"
                                ? SizedBox.shrink()
                                : SizedBox.shrink(),
                        SizedBox(
                          height: 65.h,
                        )
                      ],
                    ),
                  ),
                ),
                _saveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveButton(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 2.r, color: Colors.grey, offset: Offset(0, -4))
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  // FocusScope.of(context).unfocus();
                  final navigationProvider =
                      Provider.of<BottomNavigationProvider>(context,
                          listen: false);

                  if (widget.profile == "Business") {
                    if (businessForm.currentState!.validate()) {
                      print("ttttt");
                      await profileProvider.createBusinessProfile(
                          businessName.text,
                          businessWebsite.text,
                          businessBank.text,
                          businessLocation.text,
                          businessIndustry.text,
                          businessEstablishedYear.text,
                          businessNumberOfEmployees.text,
                          businessLookingFor.text,
                          whichType.text,
                          officialEmail.text,
                          name.text,
                          phone.text);

                      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          showCloseIcon: true,
                          content: Text('SUCCESS'),
                        ),
                      );
                      Navigator.pop(context);

                      navigationProvider.changeIndex(3);
                    }
                  } else if (widget.profile == "Investor") {
                    print("vvvvv");
                    if (investorForm.currentState!.validate()) {
                      await profileProvider.createInvestorProfile(
                          investorCompanyName.text,
                          investmentRange.text,
                          investorIndustry.text,
                          investorLocation.text,
                          investorSummary.text,
                          investorStatus.text,
                          investorSectorPreference.text,
                          name.text,
                          officialEmail.text,
                          phone.text);

                      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          showCloseIcon: true,
                          content: Text('SUCCESS'),
                        ),
                      );
                      Navigator.pop(context);

                      navigationProvider.changeIndex(3);
                    }
                  }
                },
                child: Container(
                  height: 35.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

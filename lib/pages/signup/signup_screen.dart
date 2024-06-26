import 'package:business_app/animation.dart';
import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/models/UserModel.dart';
import 'package:business_app/pages/home/home.dart';
import 'package:business_app/pages/login/login_screen.dart';
import 'package:business_app/provider/authentication_provider.dart';
import 'package:business_app/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController name = TextEditingController();
  final signFormKey = GlobalKey<FormState>();
  Box? box;

  final verticalGap = SizedBox(
    height: 8.h,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: signFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign up",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: buttonColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                verticalGap,
                                Text(
                                  "Name",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                verticalGap,
                                ReusableTextfield(
                                  controller: name,
                                  hintText: "Enter your name",
                                  keyBoard: TextInputType.text,
                                  prefixIcon: Icons.person,
                                  validation: (_) {
                                    if (name.text == "") {
                                      return "Name is required";
                                    } else if (name.text.length < 3) {
                                      return "Name must contain atleast 3 characters";
                                    }
                            
                                    return null;
                                  },
                                ),
                                verticalGap,
                                Text(
                                  "Email",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                verticalGap,
                                ReusableTextfield(
                                  controller: email,
                                  hintText: "Enter your email",
                                  keyBoard: TextInputType.emailAddress,
                                  prefixIcon: Icons.email_outlined,
                                  validation: (_) {
                                    final emailRegExp = RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                    if (email.text == "") {
                                      return "Email is required";
                                    } else if (!emailRegExp
                                        .hasMatch(email.text)) {
                                      return "Please enter valid email";
                                    }
                            
                                    return null;
                                  },
                                ),
                                verticalGap,
                                Text(
                                  "Phone number",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                verticalGap,
                                ReusableTextfield(
                                  controller: phoneNumber,
                                  hintText: "Enter your phone number",
                                  prefixIcon: Icons.phone_outlined,
                                  validation: (_) {
                                    if (phoneNumber.text == "") {
                                      return "Phone number is required";
                                    } else if (phoneNumber.text.length < 10) {
                                      return "Phone number must contain 10 digits";
                                    }
                                    return null;
                                  },
                                  keyBoard: TextInputType.number,
                                ),
                                verticalGap,
                                Text(
                                  "Password",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                verticalGap,
                                ReusableTextfield(
                                  controller: password,
                                  hintText: "Enter your password",
                                  prefixIcon: Icons.lock_outline,
                                  suffixIcon: authProvider.viewPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  obscureText:
                                      authProvider.viewPassword ? false : true,
                                  password: true,
                                  validation: (_) {
                                    // final passwordRegExp = RegExp(
                                    //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                            
                                    if (password.text == "") {
                                      return 'Password is required';
                                    }
                                    if (password.text.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }
                                    // if (!passwordRegExp.hasMatch(password.text)) {
                                    //   return 'Password must be at least 8 characters long';
                                    // }
                                    return null;
                                  },
                                  suffixIconAction:
                                      authProvider.toggleViewPassword,
                                ),
                              ],
                            ),
                            verticalGap,
                            const Text(
                              "or",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            verticalGap,
                            _socialLogin(context),
                            verticalGap,
                            Container(
                              height: 45.h,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  shadowColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16), // Padding
                                ),
                                onPressed: () async {
                                  if (signFormKey.currentState!.validate()) {
                                    final authProvider =
                                        Provider.of<AuthenticationProvider>(context,
                                            listen: false);
                        
                                    authProvider.setLoadButton(true);
                        
                                    FirebaseAuth _auth = FirebaseAuth.instance;
                        
                                    try {
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text);
                                      if (newUser != null) {
                                        debugPrint("SUCESS");
                                        await authProvider.createUserAccount(
                                            password.text,
                                            name.text,
                                            email.text,
                                            phoneNumber.text);
                        
                                        saveToSharedPreferences()
                                            .saveSignUpData(email.text);
                        
                                        authProvider.setLoadButton(false);
                        
                                        Navigator.push(context,
                                            CustomPageRoute(page: const Home()));
                                      } else {
                                        print("ERROR");
                                      }
                                    } catch (e) {
                                      print('ERROR HAPPENDED');
                                    }
                                  } else {
                                    Get.snackbar(
                                        "Error", "Please enter required details");
                                  }
                                },
                                child: authProvider.loadButton
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                        strokeAlign: 0.5,
                                      ):
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                              ),
                            ),
                            verticalGap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                LoginScreen(),
                                            transitionsBuilder: (context, animation,
                                                secondaryAnimation, child) {
                                              const begin = Offset(-1.0, 0.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;
                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(CurveTween(curve: curve));
                                              return SlideTransition(
                                                position: animation.drive(tween),
                                                child: child,
                                              );
                                            }));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color.fromRGBO(40, 122, 189, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openBox() async {
    // Open a Hive box
    box = await Hive.openBox('myBox');
  }

  _socialLogin(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              authProvider.showLoading(true);
              await authProvider.signInWithGoogle(context);
              authProvider.showLoading(false);
            },
            child: Container(
                height: 30.h,
                width: 30.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Center(
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: buttonColor,
                          strokeWidth: 1,
                          strokeAlign: 0.5,
                        )
                      : Image.asset("assets/images/Google_logo.svg"),
                )),
          ),
          Container(
            height: 30.h,
            width: 30.h,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: SvgPicture.asset(
              "assets/images/Facebook_logo.wine.svg",
              fit: BoxFit.cover,
            ),
          ),
          // Container(
          //   height: 30.h,
          //   width: 30.h,
          //   decoration: const BoxDecoration(shape: BoxShape.circle),
          //   child: Image.asset("assets/images/linkedIn.png"),
          // ),
        ],
      );
    });
  }
}

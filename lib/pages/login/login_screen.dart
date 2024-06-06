import 'package:business_app/animation.dart';
import 'package:business_app/components/reusable_textfield.dart';
import 'package:business_app/constants.dart';
import 'package:business_app/pages/home/home.dart';
import 'package:business_app/pages/signup/signup_screen.dart';
import 'package:business_app/provider/authentication_provider.dart';
import 'package:business_app/shared_preference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final verticalGap = SizedBox(
    height: 10.h,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<AuthenticationProvider>(
              builder: (context, authProvider, child) {
            return Form(
              key: loginFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                            } else if (!emailRegExp.hasMatch(email.text)) {
                              return "Please enter valid email";
                            }

                            return null;
                          },
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
                          password: true,
                          suffixIcon: authProvider.viewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          keyBoard: TextInputType.text,
                          obscureText: authProvider.viewPassword ? false : true,
                          validation: (_) {
                            if (password.text == "") {
                              return 'Password is required';
                            }
                            if (password.text.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                          suffixIconAction: authProvider.toggleViewPassword,
                        ),
                      ],
                    ),
                    verticalGap,
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 122, 189, 1),
                        ),
                      ),
                    ),
                    verticalGap,
                    const Text(
                      "or",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    verticalGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            authProvider.showLoading(true);
                            await authProvider.signInWithGoogle();
                            authProvider.showLoading(false);
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: authProvider.isLoading
                                ? const CircularProgressIndicator(
                                    color: buttonColor,
                                    strokeWidth: 1,
                                    strokeAlign: 0.5,
                                  )
                                : Image.asset("assets/images/Google_logo.svg"),
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 30.h,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            "assets/images/Facebook_logo.wine.svg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 30.h,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset("assets/images/linkedIn.png"),
                        ),
                      ],
                    ),
                    verticalGap,
                    Container(
                      height: 45.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16), // Padding
                        ),
                        onPressed: () async {
                          if (loginFormKey.currentState!.validate()) {
                            try {
                              await authProvider.loginWithEmailAndPassword(
                                  context, email.text, password.text);

                                saveToSharedPreferences()
                                        .saveSignUpData(email.text);
                              Navigator.push(
                                  context, CustomPageRoute(page: const Home()));
                            } catch (e) {
                              Get.snackbar("Something went wrong", "$e");
                            }
                          } else {
                            Get.snackbar(
                                "Hello", "Please enter required fields");
                          }
                        },
                        child: Text(
                          "Login",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                      ),
                    ),
                    verticalGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't you have an account? ",
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
                                        SignupScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(-1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }));
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              color: Color.fromRGBO(40, 122, 189, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text("click"))
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

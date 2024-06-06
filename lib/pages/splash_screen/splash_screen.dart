import 'package:business_app/animation.dart';
import 'package:business_app/pages/home/home.dart';
import 'package:business_app/pages/login/login_screen.dart';
import 'package:business_app/provider/authentication_provider.dart';
import 'package:business_app/provider/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();

    _checkUser();

    // Future.delayed(
    //  const Duration(seconds: 2),
    //   () {
    //     final authProvider =
    //         Provider.of<AuthenticationProvider>(context, listen: false);
    //     if (authProvider.isLogged) {
    //       Navigator.push(
    //         context,
    //         PageRouteBuilder(
    //           pageBuilder: (context, animation, secondaryAnimation) => Home(),
    //           transitionsBuilder:
    //               (context, animation, secondaryAnimation, child) {
    //             return FadeTransition(
    //               opacity: animation,
    //               child: child,
    //             );
    //           },
    //         ),
    //       );
    //     } else {
    //       Navigator.push(
    //         context,
    //         PageRouteBuilder(
    //           pageBuilder: (context, animation, secondaryAnimation) =>
    //               LoginScreen(),
    //           transitionsBuilder:
    //               (context, animation, secondaryAnimation, child) {
    //             return FadeTransition(
    //               opacity: animation,
    //               child: child,
    //             );
    //           },
    //         ),
    //       );
    //     }
    //   },
    // );
  
  
  
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.getString("userEmail");
    return prefs.getString("userEmail").toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // height: double.infinity,
        // width: double.infinity,
        // color: Colors.red,
        child: Image.asset(
          "assets/images/smergers-logo.png",
          // fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _checkUser() async {
    print("Started");
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString("userEmail");
    print(userEmail);

    if (userEmail != null) {
      debugPrint("userEmail not null");
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider.loadUserProfile(userEmail);
      if (profileProvider.userProfile['exists']) {
        debugPrint("userEmail is : ${profileProvider.userProfile['exists']}");
        // User exists, navigate to home screen

        Future.delayed(Duration(seconds: 2) , (){

        });
        Navigator.pushReplacement(
          context,
         CustomPageRoute(page: const Home())
        );
      } else {
        print("userEmail is null");
        //  user not exists navigate to login
        Future.delayed(Duration(seconds: 2) , (){

        });
        Navigator.pushReplacement(
          context,
         CustomPageRoute(page:  LoginScreen())
        );
      }
    }else{
      Future.delayed(Duration(seconds: 2) , (){

        });
        Navigator.pushReplacement(
          context,
         CustomPageRoute(page:  LoginScreen()));
    }
  }
}

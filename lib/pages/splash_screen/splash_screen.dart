import 'package:business_app/pages/home/home.dart';
import 'package:business_app/pages/login/login_screen.dart';
import 'package:business_app/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      if(authProvider.isLogged){
 Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
               
            );
          },
        ),
      );
      }else{
 Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
               
            );
          },
        ),
      );
      }
   
      },
      );
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
}

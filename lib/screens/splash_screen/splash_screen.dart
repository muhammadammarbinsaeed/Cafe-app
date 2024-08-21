import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:cafe_app/screens/auth_screens/login_screen.dart';
import 'package:cafe_app/screens/home/home.dart';
import 'package:cafe_app/utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
   late AnimationController animationController;
   @override
  void initState() {
    super.initState();
     animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
    Timer(const Duration(seconds: 4), () {

         FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Get.offAll(() => Home());
        } else {
          
          Get.offAll(() =>   LoginScreen());
        }
      }
      
      );
   
      
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            Container(

              child: Image.asset('assets/logo.gif',
              height: Get.height/1.4,
                    ),
            ),
               SizedBox(height: 5.0),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
                child: NeumorphicButton(
                  onPressed: () {
                    // Add the desired functionality for the button here
                  },
                  style: NeumorphicStyle(
                    depth: 4,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.food_bank_sharp,
                    size: 40,
                  ),
                ),
              ),
                SizedBox(height: 5.0),
          ],
        ),
      )
      
        );
  }
}

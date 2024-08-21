// ignore_for_file: unused_import, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cafe_app/firebase_options.dart';
import 'package:cafe_app/screens/foods/foods.dart';
import 'package:cafe_app/screens/home/home.dart';
import 'package:cafe_app/utils/color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'screens/splash_screen/splash_screen.dart';
void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configLoading();
  runApp( MyApp());
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}
class MyApp extends StatelessWidget {
   MaterialColor customColor = MaterialColor(0xff88AC12, {
      50: Color(0xff88AC12), 
      100: Color(0xff88AC12), 
      200: Color(0xff88AC12), 
      300: Color(0xff88AC12), 
      400: Color(0xff88AC12), 
      500: Color(0xff88AC12), // Use the desired color here
      600: Color(0xff88AC12), 
      700: Color(0xff88AC12), 
      800: Color(0xff88AC12), 
      900: Color(0xff88AC12), 
    });
   
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RWU Cafeteria System',
     theme: ThemeData(
        primarySwatch: customColor,
       
      ),
    
      home:  SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

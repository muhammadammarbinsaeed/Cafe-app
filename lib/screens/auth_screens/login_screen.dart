
// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cafe_app/screens/auth_screens/custom_route.dart';
import 'package:cafe_app/screens/home/home.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not exists';
      } else if (e.code == 'wrong-password') {
        return 'Password does not match';
      }
      return 'Unknown error occurred';
    }
  }
Future<String?> _recoverPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   
    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'User not found';
    }
    return 'Failed to send password reset email';
  } catch (e) {
    return 'Unknown error occurred';
  }
}
  Future<String?> _signupUser(SignupData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: data.name!,
            password: data.password!,
          );
          // .whenComplete(() => Get.offAll(HomePage()));

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email already exists';
      }
      return 'Unknown error occurred';
    }
  }

  // Future<String?> _recoverPassword(String name) {
  //   return Future.delayed(loginTime).then((_) {
  //     return null;
  //   });
  // }

  Future<String?>? _signupConfirm(String error, LoginData data) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:Color.fromARGB(95, 35, 95, 226),
      body: FlutterLogin(
        logo:  AssetImage('assets/logo.gif'),
        navigateBackAfterRecovery: true,
        onConfirmRecover: _signupConfirm,
        onConfirmSignup: _signupConfirm,
        loginAfterSignUp: false,
        termsOfService: [
          TermOfService(
            id: 'general-term',
            mandatory: true,
            text: 'Term of services',
            linkUrl: 'https://github.com/NearHuscarl/flutter_login',
          ),
        ],
        userValidator: (value) {
          if (!value!.contains('@') || !value.endsWith('.com')) {
            return "Email must contain '@' and end with '.com'";
          }
          return null;
        },
        passwordValidator: (value) {
          if (value!.isEmpty) {
            return 'Password is empty';
          }
          return null;
        },


        // login function
        onLogin: (loginData) async {
          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: loginData.name,
              password: loginData.password,
            );
            return Navigator.of(context).pushReplacement(
              FadePageRoute(
                builder: (context) => Home(),
              ),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              return 'User not exists';
            } else if (e.code == 'wrong-password') {
              return 'Password does not match';
            }
            return 'Unknown error occurred';
          }
        },
        onSignup: (signupData) async {
          try {
            debugPrint('Signup info');
            debugPrint('Name: ${signupData.name}');
            debugPrint('Password: ${signupData.password}');

            if (signupData.termsOfService.isNotEmpty) {
              debugPrint('Terms of service: ');
              for (final element in signupData.termsOfService) {
                debugPrint(
                  ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
                );
              }
            }
            return _signupUser(signupData);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'email-already-in-use') {
              return 'Email already exists';
            }
            return 'Unknown error occurred';
          }
        },
        onSubmitAnimationCompleted: () {
          // Navigator.of(context).pushReplacement(
          //   FadePageRoute(
          //     builder: (context) => HomePage(),
          //   ),
          // );
        },
        onRecoverPassword: _recoverPassword,
        
  //        (email) async {
  //   String? errorMessage = await _recoverPassword(email);
  //   return errorMessage;
  // },
        headerWidget: const IntroWidget(),
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "RWU Cafeteria System",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

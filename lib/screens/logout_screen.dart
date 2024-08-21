
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cafe_app/screens/auth_screens/login_screen.dart';

class LogoutAlertBox extends StatefulWidget {
  @override
  _LogoutAlertBoxState createState() => _LogoutAlertBoxState();
}

class _LogoutAlertBoxState extends State<LogoutAlertBox> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  void _logout() async {
    await _auth.signOut();
    Get.offAll(LoginScreen());
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Neumorphic(
        style: NeumorphicStyle(
          depth: 5,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      color: Colors.redAccent,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: 5,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_outlined, color: Colors.white),
                  ),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      color: Colors.green,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: 5,
                    ),
                    onPressed: () {
                      _logout();
                    },
                    child: Icon(Icons.check_circle_outline, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use, unused_import

import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cafe_app/utils/color.dart';

class CommonWdget {
  


/////////////////////*************DialogBox */
  static confirmBox(String titlle, String texte, VoidCallback click) {
    return Get.defaultDialog(
        title: titlle,
        middleText: texte, //"Are you sure you want to delete this user?",
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    // color: kPrimaryColor,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),

                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      click();
                      Get.back();
                      // AuthServices.deleteAccount(email);
                      //Get.back();
                    },
                    // color: Colors.red,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),

                    child: Text(
                      titlle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          )
        ]);
  }
}

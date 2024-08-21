// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:cafe_app/controller/cart_controller.dart';
import 'package:cafe_app/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';


class CustomerDetailScreen extends StatefulWidget {



  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  NewCartController _cartController = Get.put(NewCartController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Cash on Delivery'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -8,
              intensity: 0.8,
              color: Colors.white,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Delivery Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                         if (value!.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length > 11) {
      return 'Phone number should not exceed 11 characters';
    }
    return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        depth: 8,
                        intensity: 0.6,
                        color: primaryColor,
                        shape: NeumorphicShape.flat,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                                EasyLoading.show(status: 'Uploading...');

                           // after validating the form
        CollectionReference orders = FirebaseFirestore.instance.collection('orders');
        double totalPrice = _cartController.products.fold(0, (sum, product) => sum + (product.price*product.quantity));

        orders.add({
          'name': _nameController.text,
          'email':FirebaseAuth.instance.currentUser!.email,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'item': _cartController.products.map((product) => product.toMap()).toList(),
            'totalPrice': totalPrice,
           'dateTime':DateTime.now() ,
           'is_aprove':false,
           'is_reject':false,

        }).then((value) {
                EasyLoading.dismiss();

          Get.snackbar("Success", "Order successfully placed");
        }).catchError((error) {
                EasyLoading.dismiss();

                print(error);

          Get.snackbar("Error", "Failed to place order: $error");
        });
         
      

                        
                        }
                      },
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  'Note: Delivery charges will be applied.(10 to 20 ./Rs)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
    
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

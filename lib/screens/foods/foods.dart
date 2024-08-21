// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cafe_app/controller/cart_controller.dart';
import 'package:cafe_app/models/product.dart';
import 'package:cafe_app/screens/cart/cart.dart';
import 'package:cafe_app/screens/foods/food_detail.dart';
import 'package:cafe_app/utils/color.dart';

class FoodScreenn extends StatefulWidget {
  @override
  State<FoodScreenn> createState() => _FoodScreennState();
}

class _FoodScreennState extends State<FoodScreenn> {
  NewCartController _newcartController = Get.put(NewCartController());

  double userBMI = 25.0;
  List<String>? selectedDiseases = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Food Items",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Get.to(() => Cart());
              },
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: primaryColor,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _newcartController.products.length != 0
                          ? Text(
                              _newcartController.products.length.toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : SizedBox(
                              width: 0,
                              height: 0,
                            ),
                      ClipOval(
                        child: Icon(
                          Icons.shopping_cart_sharp,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildNeumorphicContainer(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NeumorphicText(
                        
"Savor the flavor, at your fingertips!",
                        style: NeumorphicStyle(
                          depth: 8,
                          color: Color.fromARGB(255, 28, 28, 28),
                          shadowLightColor: Colors.white,
                          shadowDarkColor: Colors.grey.shade400,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          intensity: 0.6,
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          // color: Color(0xFF3E3E3E),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _buildMealPlan(context),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealPlan(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foodItems').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Widget> mealCards = [];
        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          mealCards.add(_buildMealCard(
            context,
            data['title'],
            data['price'].toString(),
            // data['kcal'],
            data['image_url'],
          ));
        }

        if (mealCards.isEmpty) {
          return Text(
              'No Food items found');
        }

        return Column(children: mealCards);
      },
    );
  }

  Widget _buildMealCard(
      BuildContext context, String title, String price, String imageUrl) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;
    final imageHeight = cardWidth * 0.4;
    final contentHeight = cardWidth * 0.6;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: cardWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: cardWidth * 0.04,
                          color: Colors.grey[700],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 4),
                      Text(
                        './Rs',
                        style: TextStyle(
                          fontSize: cardWidth * 0.04,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.food_bank, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Special Offer!',
                        style: TextStyle(
                          fontSize: cardWidth * 0.04,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          try {
                            _newcartController.selectedProducts.add({
                              "quantity": 1,
                            });
                            _newcartController.products.add(
                              Product(
                                title.toString(),
                                double.parse(price.toString()),
                                imageUrl.toString(),
                                1.0,
                              ),
                            );
                          } catch (e) {
                            print(e.toString());
                          }

                          Get.snackbar(
                            "Added",
                            "Item added successfully to cart",
                            colorText: Colors.white,
                            backgroundColor: primaryColor,
                            icon: Icon(Icons.add, color: Colors.white),
                            isDismissible: true,
                          );
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: cardWidth * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              horizontal: cardWidth * 0.06,
                              vertical: cardWidth * 0.03,
                            ),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                title: title,
                                description: price,
                                imageUrl: imageUrl,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontSize: cardWidth * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              horizontal: cardWidth * 0.06,
                              vertical: cardWidth * 0.03,
                            ),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeumorphicContainer({required Widget child}) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 5.0,
        intensity: 1.0,
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: child,
    );
  }
}

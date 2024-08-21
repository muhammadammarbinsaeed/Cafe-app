
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:cafe_app/controller/cart_controller.dart';
import 'package:cafe_app/models/product.dart';
import 'package:cafe_app/utils/color.dart';
class DetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  // final String calories;

  const DetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    // required this.calories,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
    NewCartController _newcartController = Get.put(NewCartController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Back Button
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: -3,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: NeumorphicIcon(
                            style:NeumorphicStyle(color: primaryColor),
                            Icons.arrow_back_ios_rounded,
                            size: screenWidth * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                // Image and Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: 2,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            height: screenWidth * 0.7,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          NeumorphicIcon(
                            style:NeumorphicStyle(color: Colors.red),
                            Icons.local_fire_department_rounded,
                            size: screenWidth * 0.04,
                          ),
                          SizedBox(width: 4),
                          // Text(
                          //   '${widget.calories} calories',
                          //   style: TextStyle(
                          //     fontSize: screenWidth * 0.04,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
          
                // Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.description+' /Rs',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
          
                // Action Buttons
             
           Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    NeumorphicButton(
      onPressed: (){
         try {
                                            _newcartController.selectedProducts
                                                .add({
                                              "quantity": 1,
                                              // "merchandiseId": base64
                                              //     .encode(utf8.encode(
                                              //         _shopeController
                                              //             .productId[index]
                                              //             .toString()))
                                              //     .toString()
                                            });
                                            _newcartController.products.add(
                                                Product(
                                                    this.widget.title
                                                        .toString(),
                                                  double.parse(this.widget.description.toString()),
                                                    this.widget.imageUrl
                                                        .toString(),
                                                    1.0));
                                          } catch (e) {
                                            print(e.toString());
                                          }

                                          Get.snackbar(
                                            "Added",
                                            "Item added successfuly in to cart",
                                            colorText: Colors.white,
                                            backgroundColor: primaryColor,
                                            icon: Icon(Icons.add,
                                                color: Colors.white),
                                            isDismissible: true,
                                          );
      },
      style: NeumorphicStyle(
        color: Colors.grey[200],
        depth: 4,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Text('Add to Cart'),
    ),
    ],
),]
                  ),
          ),
      
    ),
  
);
}
}
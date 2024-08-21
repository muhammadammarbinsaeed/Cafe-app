// import 'package:flutter/foundation.dart';
// ignore_for_file: unused_import, prefer_final_fields, unused_field

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cafe_app/screens/cart/cart.dart';
import 'package:cafe_app/screens/contact_us/contact_us.dart';
import 'package:cafe_app/screens/drawerr.dart';
import 'package:cafe_app/screens/foods/foods.dart';
import 'package:cafe_app/screens/orders.dart';
import 'package:cafe_app/utils/color.dart';
import 'package:cafe_app/controller/cart_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  NewCartController _newcartController = Get.put(NewCartController());
  List slides = [
    'assets/unilogo.png',
  'assets/uni.jpeg',
  'assets/food.jpg',
  ];
  CarouselSliderController carouselController =  CarouselSliderController();
  int carouselIndex = 0;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
    late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
    appBar:  PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
      ),
     drawer: Drawer(child: Drawerr.drawerr()),
      // backgroundColor: kPrimaryLightColor,
      // appBar: CommonWdget.appbar("Home"),
      body: SafeArea(
          child: Container(
             decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromARGB(255, 185, 220, 238), Color.fromARGB(255, 96, 139, 124)], // Replace with your desired gradient colors
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  ),
      //       decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/uni.jpeg'), // Replace with your image path
      //     fit: BoxFit.cover,
      //   ),
      // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                 Container(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         ClipRRect(
  borderRadius: BorderRadius.circular(24.0),
  child: Image.asset(
    'assets/logo.gif',
    height: 48,
  ),
),

                          SizedBox(width: 8),
                          Text(
                            'RWU Cafeteria System',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF2F1F1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'WelCome',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 29, 28, 28),
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: slides.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return Container(
                            // height: kIsWeb ? Get.height / 1.5 : Get.height / 3,
                            // width: kIsWeb ? Get.width / 2 : Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        slides.elementAt(index).toString()))),
                          );
                        },
                        options: CarouselOptions(
                            height:
                                // kIsWeb ? 420 :
                                200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1700),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, carouselReason) {
                              setState(() {
                                carouselIndex = index;
                              });
                            })),
                  ),
                  CarouselIndicator(
                    color: Colors.grey,
                    activeColor: Colors.black,
                    width: Get.width * 0.05,
                    height: 2,
                    count: slides.length,
                    index: carouselIndex,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                         // Menu section
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildMenuItem(context, 'Food Items', Icons.food_bank_sharp, () {
                          Get.to(FoodScreenn());
                      
                        }),
                        SizedBox(height: 16),
                        buildMenuItem(context, 'My Cart', Icons.shopping_cart_sharp, () {
                        Get.to(() => Cart());
                        
                        }),
                        SizedBox(height: 16),
                        buildMenuItem(context, 'Contact us', Icons.contact_mail, () {
                          Get.to(ContactForm());
                        }),
                        SizedBox(height: 16),
                        buildMenuItem(context, 'My Orders', Icons.shopping_cart, () {
                          Get.to(OrdersScreen());
                        }),
                      ],
                    ),
                  ),
                ),
                        
                       
                      ],
                    ),
                  ),
              
                                ],
              ),
            ),
          ),
        ),
      )),
    );
  }









  
  Widget buildMenuItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 28,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

}

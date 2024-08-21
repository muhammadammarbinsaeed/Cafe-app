import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cafe_app/common_widget.dart/common_widget.dart';
import 'package:cafe_app/controller/cart_controller.dart';
import 'package:cafe_app/screens/cart/cart_widget.dart';
import 'package:cafe_app/screens/cart/customer_detail.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  NewCartController _cartController = Get.put(NewCartController());

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
          "Shopping Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _cartController.products.length > 0
              ? Obx(
                  () => Stack(
                    children: [
                      _cartController.products.length <= 0
                          ? Center(
                              child: Text("Cart empty"),
                            )
                          : Positioned(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height / 6.2),
                                child: ListView.builder(
                                  itemCount: _cartController.products.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Divider(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onLongPress: () {
                                            CommonWdget.confirmBox(
                                              "Remove",
                                              "Do you want to remove this item from cart?",
                                              () {
                                                _cartController.products
                                                    .removeAt(index);
                                                _cartController.selectedProducts
                                                    .removeAt(index);
                                              },
                                            );
                                          },
                                          child: Card(
                                            color: Colors.grey[300],
                                            elevation: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CatalogProductsCard(
                                                index: index,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                          ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: _cartController.products.length > 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(CustomerDetailScreen()); // Navigate to the checkout form page
                              },
                              child: Text('Checkout'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text("Empty Cart"),
                ),
         
            Positioned(
              bottom: 50,
              right: 10,
              child: Container(
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
            ),
        ],
      ),
    );
  }
}

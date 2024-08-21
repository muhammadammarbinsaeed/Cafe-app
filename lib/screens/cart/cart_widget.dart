import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cafe_app/common_widget.dart/common_widget.dart';
import 'package:cafe_app/controller/cart_controller.dart';
import 'package:cafe_app/screens/cart/cart.dart';
import 'package:cafe_app/utils/color.dart';

class CatalogProducts extends StatefulWidget {
  CatalogProducts({Key? key}) : super(key: key);

  @override
  State<CatalogProducts> createState() => _CatalogProductsState();
}

class _CatalogProductsState extends State<CatalogProducts> {
  NewCartController _cartController = Get.put(NewCartController());
  @override
  void initState() {
    print(_cartController.selectedProducts.toString());
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
      body: SafeArea(
        child: Stack(
          children: [
            _cartController.products.length > 0
                ? Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 6.2),
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
                                    CommonWdget.confirmBox("Remove",
                                        "Do you want to remove this item from cart?",
                                        () {
                                      _cartController.products.removeAt(index);
                                    });
                                  },
                                  child: Card(
                                    color: Colors.grey[300],
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CatalogProductsCard(index: index),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                : Center(
                    child: Text("Empty Cart"),
                  ),
            Positioned(
                bottom: 30,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(Cart());
                      },
                      child: PhysicalModel(
                        color: Colors.grey.withOpacity(.4),
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(14),
                              alignment: Alignment.center,
                              child: Text(
                                "Check out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class CatalogProductsCard extends StatefulWidget {
  final int index;
  CatalogProductsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CatalogProductsCard> createState() => _CatalogProductsCardState();
}

class _CatalogProductsCardState extends State<CatalogProductsCard> {
  NewCartController _cartController = Get.put(NewCartController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            _cartController.products[widget.index].imgUrl.toString().toString(),
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 14,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _cartController.products[widget.index].name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     padding: EdgeInsets.all(7),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         color: primaryColor),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         InkWell(
                //             onTap: () {
                //               _cartController.deccrement(widget.index);
                //               setState(() {
                //                 _cartController.selectedProducts[widget.index]
                //                         ["quantity"] =
                //                     _cartController
                //                             .selectedProducts[widget.index]
                //                         ["quantity"];
                //               });
                //             },
                //             child: Icon(
                //               Icons.remove,
                //               color: Colors.white,
                //               size: 30,
                //             )),
                //         Container(
                //           margin: EdgeInsets.symmetric(horizontal: 3),
                //           padding:
                //               EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(3),
                //               color: Colors.white),
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 12),
                //             child: Obx(
                //               () => Text(
                //                 _cartController.selectedProducts[widget.index]
                //                         ["quantity"]
                //                     .toString(),
                //                 style: TextStyle(
                //                     color: Colors.black, fontSize: 20),
                //               ),
                //             ),
                //           ),
                //         ),
                //         InkWell(
                //             onTap: () {
                //               _cartController.increment(widget.index);
                //               setState(() {
                //                 _cartController.selectedProducts[widget.index]
                //                         ["quantity"] =
                //                     _cartController
                //                             .selectedProducts[widget.index]
                //                         ["quantity"];
                //               });
                //             },
                //             child: Icon(
                //               Icons.add,
                //               color: Colors.white,
                //               size: 30,
                //             )),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Text(
                    (_cartController.products[widget.index].price *
                                _cartController.selectedProducts[widget.index]
                                    ["quantity"])
                            .toStringAsFixed(3)
                            .toString() +
                        " \Rs",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                  InkWell(
                    onTap: () {
                     CommonWdget.confirmBox("Remove",
                                        "Do you want to remove this item from cart?",
                                        () {
                                      _cartController.products.removeAt(this.widget.index);
                                    });
                                  
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                
              ],
            ),
          ],
        )),
      ],
    );
  }
}

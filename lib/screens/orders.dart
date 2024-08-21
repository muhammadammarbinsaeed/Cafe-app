import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cafe_app/common_widget.dart/common_widget.dart';
import 'package:cafe_app/screens/feedback_screen/feedback_screen.dart';
import 'package:cafe_app/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Orders'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildPendingOrders(),
            buildApprovedOrders(),
            buildRejectedOrders(),
          ],
        ),
      ),
    );
  }

  Widget buildPendingOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('orders')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).where('is_aprove',isEqualTo: false,).where('is_reject',isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            var id = document.id;
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return buildOrderItem(data, id);
          }).toList(),
        );
      },
    );
  }

  Widget buildRejectedOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('orders')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).where('is_reject',isEqualTo: true).where('is_aprove',isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            var id = document.id;
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return buildOrderItem(data, id);
          }).toList(),
        );
      },
    );
  }
   Widget buildApprovedOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('orders')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).where('is_reject',isEqualTo: false).where('is_aprove',isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            var id = document.id;
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return buildOrderItem(data, id);
          }).toList(),
        );
      },
    );
  }

  Widget buildOrderItem(Map<String, dynamic> data, String id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.grey[200],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  data['email'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("tel:${data['phone']}");
                  },
                  child: Text(
                    data['phone'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  "Total: " + data['totalPrice'].toString() + " /Rs",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Column(
                  children: data['item'].map<Widget>((item) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['imgUrl'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Price: ${item['price']}',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(FeedbackPage());
                  },
                  child: Text(
                    'Give Feedback',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                if (data['is_aprove'])
                  Text('Order Approved',
                      style: TextStyle(color: Color.fromARGB(255, 18, 95, 237)))
                else if (data['is_reject'])
                  Text('Order Rejected', style: TextStyle(color: Colors.red))
                else
                  ElevatedButton(
                    onPressed: () async {
                      CommonWdget.confirmBox(
                          "Remove Order",
                          "Are you sure you want to remove this order?",
                          () async {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(id)
                            .delete();
                      });
                    },
                    child: Text(
                      'Remove Order',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

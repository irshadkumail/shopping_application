import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/orders/order_item.dart';
import 'file:///C:/Users/Irshad%20Kumail/Desktop/Apps/shopping_app/lib/orders/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const route = "order-screen";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Order History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<void>(
            future: provider.getOrders(FirebaseAuth.instance.currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else
                return ListView.builder(
                  itemBuilder: (ctx, pos) =>
                      OrderItemWidget(provider.orderList[pos]),
                  itemCount: provider.orderList.length,
                );
            }),
      ),
    );
  }
}


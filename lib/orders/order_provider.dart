import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/checkout/cart_provider.dart';

import '../home/product_provider.dart';

class Order {
  final String id;
  final int totalAmount;
  final List<CartItem> cartItems;
  final DateTime orderDateTime;
  String status;

  Order(this.id, this.totalAmount, this.cartItems, this.orderDateTime);

  factory Order.forJson(String orderId, Map<String, dynamic> map) {
    print(orderId);
    final cartItems = map["cartItems"] as List<dynamic>;
    print(cartItems.length);

    return Order(
        orderId,
        map["amount"],
        cartItems.map((item) => CartItem(
            product: Product.fromJson(item["product"]["id"], item["product"]),
            quantity: item["quantity"])).toList(),
        DateTime.parse(map["orderTime"]));
  }
}

class OrderProvider with ChangeNotifier {
  List<Order> orderList = [];

  Future<void> doCheckout(
      String userId, int totalAmount, List<CartItem> cartItems) async {
    var url = "https://shopperappv3.firebaseio.com/orders/${userId}.json";
    orderList.clear();
    var response = await http.post(url,
        body: jsonEncode({
          "amount": totalAmount,
          "orderTime": DateTime.now().toIso8601String(),
          "cartItems": cartItems.map((cart) => cart.toJsonMap()).toList()
        }));
    print(response.body);
    notifyListeners();
  }

  Future<void> getOrders(String userId) async {
    try {
      final url = "https://shopperappv3.firebaseio.com/orders/${userId}.json";
      final response = await http.get(url);
      orderList.clear();
      print(response.body);
      final orderMap = jsonDecode(response.body) as Map<String, dynamic>;
      orderMap.forEach((key, value) {
        orderList.add(Order.forJson(key, value));
      });
      print(orderList.length.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}

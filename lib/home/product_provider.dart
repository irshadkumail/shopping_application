import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product {
  final String description;
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  bool isFavorite;

  Product(
      {this.description,
      this.id,
      this.title,
      this.imageUrl,
      this.price,
      this.isFavorite = false});

  Map<String, dynamic> toJsonMap() => {
        "description": description,
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "price": price
      };

  factory Product.fromJson(String productId, Map<String, dynamic> productDetails) {
    return Product(
        title: productDetails["title"],
        description: productDetails["description"],
        imageUrl: productDetails["imageUrl"],
        id: productId,
        price: productDetails["price"] as int);
  }
}

class ProductProvider with ChangeNotifier {
  var _productList = List<Product>();

  List<Product> get productList => _productList;

  Future<void> fetchAndSetProduct() async {
    try {
      const url = "https://shopperappv3.firebaseio.com/products.json";
      final response = await get(url);
      final responseMap = jsonDecode(response.body) as Map<String, Object>;
      productList.clear();
      print(response.body);
      responseMap.forEach((productId, value) {
        _productList.add(Product.fromJson(productId, value));
      });
      printAll();
    } catch (e) {
      print(e.toString());
    }
  }

  void printAll() {
    _productList.forEach((product) {
      print(product.title);
    });
  }
}

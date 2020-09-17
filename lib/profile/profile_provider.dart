import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AddressType { Home, Work, Other }

class Address {
  String id;
  final AddressType addressType;
  final String address;
  final String landmark;

  Address(
      {@required this.addressType,
      @required this.address,
      @required this.landmark});

  String toJson() {
    return jsonEncode({
      "type": addressType.toString(),
      "address": address,
      "landmark": landmark,
    });
  }

  factory Address.fromJson(Map<String, dynamic> addressMap) => Address(
      addressType: AddressType.Home,
      address: addressMap["address"],
      landmark: addressMap["landmark"]);
}

class ProfileProvider with ChangeNotifier {
  List<Address> addressList = [];
  String username = "";

  Future<void> getAndSetProfile(String userId) async {
    try {
      final url = "https://shopperappv3.firebaseio.com/profiles/${userId}.json";
      final response = await http.get(url);
      final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
      addressList.clear();
      responseMap["addresses"].forEach((key, value) {
        print(key);
        addressList.add(Address.fromJson(value));
      });

      print("Size ${addressList.length}");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addToAddressBook(String userId, Address address) async {
    try {
      final url =
          "https://shopperappv3.firebaseio.com/profiles/${userId}/addresses.json";
      await http.post(url, body: address.toJson());
      addressList.add(address);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteAddress(String userId, String addressId) async {
    final url =
        "https://shopperappv3.firebaseio.com/profiles/${userId}/addresses/${addressId}.json";
    await http.delete(url);
  }

  Future<void> updateUsername(String userId, String username) async {
    try {
      final url = "https://shopperappv3.firebaseio.com/profiles/${userId}.json";
      await http.post(url, body: {"username": username});
      notifyListeners();
    } catch (e) {}
  }
}

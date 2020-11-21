
import 'package:flutter/widgets.dart';

import '../home/product_provider.dart';

class CartItem {
  int quantity;
  final Product product;

  CartItem({this.product, this.quantity = 1});

  void increaseQuantityBy(int count) {
    quantity += count;
  }

  int getAmount() => product.price * quantity;

  Map<String, dynamic> toJsonMap() =>
      {"quantity": quantity, "product": product.toJsonMap()};
}

class CartProvider with ChangeNotifier {
  List<CartItem> cartItems = [];

  int get totalCartAmount => cartItems.fold(
      0, (previousValue, cartItem) => previousValue + cartItem.getAmount());

  void addToCart({Product product, int count = 1}) {
    CartItem cartItem = cartItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => null);
    if (cartItem == null) {
      cartItems.add(new CartItem(product: product, quantity: count));
    } else {
      cartItem.increaseQuantityBy(count);
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.removeWhere((item) => item.product.id == cartItem.product.id);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}

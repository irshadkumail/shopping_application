import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/checkout/cart_provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Colors.amber,
            size: 30,
          ),
          if (provider.cartItems.isNotEmpty)
            Positioned(
              right: 0,
              top: 5,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${provider.cartItems.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

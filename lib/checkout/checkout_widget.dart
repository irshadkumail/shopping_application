import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/checkout/cart_item.dart';
import 'package:shopping_app/checkout/cart_provider.dart';
import 'package:shopping_app/checkout/success_screen.dart';
import 'package:shopping_app/orders/order_provider.dart';

class CheckoutWidget extends StatefulWidget {
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  CartProvider provider;
  var inProgress = false;

  void initCheckout() async {
    setState(() => inProgress = true);
    await Provider.of<OrderProvider>(context, listen: false).doCheckout(
        FirebaseAuth.instance.currentUser.uid,
        provider.totalCartAmount,
        provider.cartItems);
    provider.clearCart();
    setState(() => inProgress = false);
    Navigator.popAndPushNamed(context, SuccessScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CartProvider>(context);

    return provider.cartItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, pos) =>
                        CartItemWidget(provider.cartItems[pos]),
                    itemCount: provider.cartItems.length,
                  ),
                ),
                if (inProgress) CircularProgressIndicator(),
                if (!inProgress)
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: RaisedButton(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text("Checkout \$${provider.totalCartAmount}"),
                        color: Colors.amber,
                        onPressed: initCheckout),
                  )
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.remove_shopping_cart, size: 50),
                Text("Cart is Empty")
              ],
            ),
          );
  }
}

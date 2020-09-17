import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/checkout/cart_provider.dart';


class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => Provider.of<CartProvider>(context, listen: false)
          .removeFromCart(cartItem),
      key: ValueKey(cartItem.product.id),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete_forever, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(cartItem.product.imageUrl),
          radius: 30,
        ),
        title: Text(cartItem.product.title),
        subtitle: Text("\$${cartItem.product.price}"),
        trailing: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 18,
          child: Text(
            "x${cartItem.quantity}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

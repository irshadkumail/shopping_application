import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file:///C:/Users/Irshad%20Kumail/Desktop/Apps/shopping_app/lib/orders/order_provider.dart';


class OrderItemWidget extends StatefulWidget {
  final Order order;

  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ExpansionTile(
              leading: SizedBox(
                height: 40,
                width: 40,
                child: FittedBox(
                  alignment: Alignment.center,
                  child: Text(
                    "\$${widget.order.totalAmount.toString()}",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ),
              title: Text(
                "Order #${widget.order.id.substring(widget.order.id.length - 8)}",
                style: TextStyle(color: Colors.blue),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(widget.order.orderDateTime),
                style: TextStyle(color: Colors.grey),
              ),
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, pos) => Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                                "${widget.order.cartItems[pos].product.title} x ${widget.order.cartItems[pos].quantity}")),
                        Text("\$${widget.order.cartItems[pos].getAmount()}")
                      ],
                    ),
                    itemCount: widget.order.cartItems.length)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
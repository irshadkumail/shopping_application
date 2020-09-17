import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/checkout/cart_provider.dart';
import 'file:///C:/Users/Irshad%20Kumail/Desktop/Apps/shopping_app/lib/home/product_provider.dart';

class ProductDetail extends StatelessWidget {
  static const route = "product-detail";
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: product.id,
              child: Image.network(
                product.imageUrl,
                height: 320,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 10),
            Text(product.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
            SizedBox(height: 20),
            Row(children: <Widget>[
              CartCounter(1, (newCounter) => counter = newCounter),
              Spacer(),
              Text("\$${product.price}",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 30),
            Text(product.description),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("Add to cart"),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(product: product, count: counter);
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CartCounter extends StatefulWidget {
  int counter = 1;

  void Function(int) onCounterChanged;

  CartCounter(this.counter, this.onCounterChanged);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(width: 1, color: Colors.amber)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (widget.counter == 1) return;
                setState(() => widget.counter--);
                widget.onCounterChanged(widget.counter);
              }),
          Text(
            widget.counter.toString(),
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() => widget.counter++);
                widget.onCounterChanged(widget.counter);
              })
        ],
      ),
    );
  }
}

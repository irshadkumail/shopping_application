import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/home/product_provider.dart';
import 'package:shopping_app/screens/product_detail.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context).productList;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, pos) => ProductWidget(products[pos]),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3)),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetail.route, arguments: product),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: <Widget>[
              Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 130,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.favorite_border), onPressed: () {})
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  product.title,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        elevation: 4,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/checkout/checkout_widget.dart';


import 'all_products.dart';
import 'cart_icon.dart';
import 'home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = "home-screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  void _onNavigation(int selection) {
    setState(() {
      _currentPageIndex = selection;
    });
  }

  void showCartItems(BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => CheckoutWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets Shop"),
        centerTitle: true,
        actions: <Widget>[
          InkWell(child: CartIcon(), onTap: () => showCartItems(context))
        ],
      ),
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          onTap: _onNavigation,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.donut_small), title: Text("All")),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text("Favorites"))
          ]),
      body: _currentPageIndex == 1 ? FavoritesPage() : AllProducts(),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Favorites"));
  }
}


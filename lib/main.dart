import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/checkout/cart_provider.dart';
import 'package:shopping_app/checkout/success_screen.dart';
import 'package:shopping_app/home/product_provider.dart';
import 'package:shopping_app/login/otp_screen.dart';
import 'package:shopping_app/orders/order_provider.dart';
import 'package:shopping_app/orders/orders_screen.dart';
import 'package:shopping_app/profile/profile_provider.dart';
import 'package:shopping_app/profile/profile_screen.dart';
import 'package:shopping_app/screens/product_detail.dart';
import 'package:shopping_app/screens/splash_screen.dart';

import 'home/home_screen.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrderProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.amber),
        home: SplashScreen(),
        routes: {
          ProfileScreen.route: (ctx) => ProfileScreen(),
          SplashScreen.route: (ctx) => SplashScreen(),
          ProductDetail.route: (ctx) => ProductDetail(),
          OtpScreen.route: (ctx) => OtpScreen(),
          HomeScreen.route: (ctx) => HomeScreen(),
          SuccessScreen.route: (ctx) => SuccessScreen(),
          OrdersScreen.route: (ctx) => OrdersScreen()
        },
      ),
    );
  }
}

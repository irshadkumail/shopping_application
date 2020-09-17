import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/home/home_screen.dart';
import 'package:shopping_app/home/product_provider.dart';
import 'package:shopping_app/login/phone_screen.dart';


class SplashScreen extends StatelessWidget {
  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProduct();
    var firebase = Firebase.initializeApp();

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Future.wait([products, firebase]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AnimatedIcon();
            } else if (FirebaseAuth.instance.currentUser != null) {
              return HomeScreen();
            } else {
              return PhoneScreen();
            }
          },
        ));
  }
}

class AnimatedIcon extends StatefulWidget {
  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat();
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Center(
          child: Icon(
        Icons.shopping_cart,
        size: 60,
      )),
    );
  }
}

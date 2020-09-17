import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/orders/orders_screen.dart';
import 'package:shopping_app/profile/profile_screen.dart';
import 'package:shopping_app/screens/splash_screen.dart';

class HomeDrawer extends StatelessWidget {
  static const List<DrawerItem> drawerItems = [
    DrawerItem(Icons.person, "Profile"),
    DrawerItem(Icons.shopping_cart, "Orders"),
    DrawerItem(Icons.subdirectory_arrow_left, "Logout")
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemBuilder: (ctx, pos) => _DrawerItemWidget(
            drawerItems[pos], (name) => handleItemClick(context, name)),
        itemCount: drawerItems.length,
      ),
    );
  }

  void handleItemClick(BuildContext context, String name) {
    switch (name) {
      case "Profile":
        Navigator.of(context).pushNamed(ProfileScreen.route);
        break;
      case "Orders":
        Navigator.of(context).pushNamed(OrdersScreen.route);
        break;
      case "Logout":
        print("lOGG");
        FirebaseAuth.instance.signOut().then(
            (value) => Navigator.of(context).pushNamed(SplashScreen.route));
        break;
    }
  }
}

class _DrawerItemWidget extends StatelessWidget {
  final DrawerItem drawerItem;
  final Function(String) onClicked;

  _DrawerItemWidget(this.drawerItem, this.onClicked);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        drawerItem.iconData,
        color: Colors.amber,
      ),
      title: Text(drawerItem.label),
      onTap: () => onClicked.call(drawerItem.label),
    );
  }
}

class DrawerItem {
  final IconData iconData;
  final String label;

  const DrawerItem(this.iconData, this.label);
}

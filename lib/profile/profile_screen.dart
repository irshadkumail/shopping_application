import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/profile/add_address.dart';
import 'package:shopping_app/profile/address_card.dart';
import 'package:shopping_app/profile/profile_provider.dart';
import 'package:shopping_app/profile/username_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const route = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void addAddress(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddAddress(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
            future: Provider.of<ProfileProvider>(context, listen: false)
                .getAndSetProfile(FirebaseAuth.instance.currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: <Widget>[
                    UsernameWidget(),
                    SizedBox(height: 30),
                    Divider(height: 1, color: Colors.black54),
                    SizedBox(height: 30),
                    Consumer<ProfileProvider>(
                      builder: (_, provider, _2) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.add_location, color: Colors.grey),
                          ),
                          Expanded(
                            child: Column(
                              children: provider.addressList
                                  .map((address) => AddressCard(address))
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}

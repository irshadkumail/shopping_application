import 'package:flutter/material.dart';
import 'package:shopping_app/profile/profile_provider.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  AddressCard(this.address);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: TextEditingController(text: address.address),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.amber),
                  labelText: "Address",
                  disabledBorder: InputBorder.none),
            ),
            TextField(
              enabled: false,
              maxLines: 2,
              controller: TextEditingController(text: address.landmark),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.amber),
                  labelText: "Landmark",
                  disabledBorder: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}

class AddAddressButton extends StatelessWidget {
  final Function onPressed;

  AddAddressButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.amber,
        onPressed: onPressed,
        child: Text("Add Address"));
  }
}

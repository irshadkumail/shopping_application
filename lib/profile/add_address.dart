import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/helper.dart';
import 'file:///C:/Users/Irshad%20Kumail/Desktop/Apps/shopping_app/lib/profile/profile_provider.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  var _formKey = GlobalKey<FormState>();
  String _address;
  String _landmark;
  bool _inProgress = false;

  void saveAddress(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _inProgress = true;
      });
      _formKey.currentState.save();
      await Provider.of<ProfileProvider>(context, listen: false)
          .addToAddressBook(
              FirebaseAuth.instance.currentUser.uid,
              Address(
                  addressType: AddressType.Home,
                  landmark: _landmark,
                  address: _address));
      _inProgress = false;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  validator: validateEmptyString,
                  onSaved: (val) => _address = val,
                  decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.amber),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber)),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: validateEmptyString,
                  onSaved: (val) => _landmark = val,
                  decoration: InputDecoration(
                      labelText: "Landmark",
                      labelStyle: TextStyle(color: Colors.amber),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber)),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
                SizedBox(height: 10),
                if (_inProgress)
                  Container(
                      height: 20,
                      width: 20,
                      margin: EdgeInsets.only(top: 16,right: 16),
                      child: CircularProgressIndicator()),
                if (!_inProgress)
                  FlatButton.icon(
                      onPressed: () => saveAddress(context),
                      icon: Icon(Icons.add_location),
                      label: Text("Add")),
                SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

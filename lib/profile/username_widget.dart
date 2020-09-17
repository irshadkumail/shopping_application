import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsernameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(Icons.person, color: Colors.grey),
        ),
        SizedBox(width: 12),
        Expanded(
            child: Column(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: TextEditingController(
                  text: FirebaseAuth.instance.currentUser.phoneNumber),
              decoration: InputDecoration(
                  labelText: "Mobile number",
                  disabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(color: Colors.amber)),
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                  labelText: "Username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(color: Colors.amber),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(208, 208, 208, 1)))),
            ),
          ],
        ))
      ],
    );
  }
}

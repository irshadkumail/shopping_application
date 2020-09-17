import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/helper.dart';
import 'package:shopping_app/login/otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  static const String route = "phone-screen";

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _inputController = TextEditingController();
  bool verifyEnabled = false;

  Future<void> verifyClicked(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+971"+_inputController.text,
        verificationCompleted: (phoneCredentials) {
          print(phoneCredentials.toString());
        },
        verificationFailed: (exception) {
          print(exception.toString());
        },
        codeSent: (verificationId, resendToken) {
          print(verificationId);
          Navigator.pushNamed(context, OtpScreen.route,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() {
      verifyEnabled = _inputController.text.length == 9;
      if (verifyEnabled) setState(() {});
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 130),
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/shopperappv3.appspot.com/o/login_ecommerce.png?alt=media",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 40),
              Text(
                "Please enter your mobile number to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                maxLength: 9,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: "Phone number",
                    prefixText: "+971 ",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(color: Colors.amber),
                    focusColor: Colors.amber,
                    enabledBorder: getInputFieldBorder(),
                    focusedBorder: getInputFieldBorder(),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 100),
              if (verifyEnabled)
                SizedBox(
                    width: 300,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () => verifyClicked(context),
                      disabledColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.amber,
                      child: Text("Verify"),
                    ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}

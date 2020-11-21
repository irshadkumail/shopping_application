import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/helper.dart';

import '../home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  static const route = "otp-screen";

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _inputController = TextEditingController();
  bool _inProgress = false;

  void verifyOtp(String verificationID, String sms) async {
    try {
      final phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: sms);
      await FirebaseAuth.instance.signInWithCredential(phoneCredential);
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    } catch (e) {
      print(e.code);
      print(e.message);
      setState(() {
        _inProgress = false;
        _inputController.clear();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final verificationId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/shopperappv3.appspot.com/o/otp-icon.png?alt=media",
              width: 65,
              height: 65,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text(
              "Please enter the OTP sent on the registered mobile number",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (!_inProgress)
              SizedBox(
                width: 160,
                child: TextField(
                  onChanged: (text) {
                    if (text.length == 6) {
                      setState(() => _inProgress = true);
                      verifyOtp(verificationId, text);
                    }
                  },
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      focusedBorder: getInputFieldBorder(),
                      enabledBorder: getInputFieldBorder()),
                  maxLength: 6,
                  textAlign: TextAlign.center,
                ),
              ),
            if (_inProgress) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  static const route = "success";

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
                width: 100,
                height: 100,
                child: FlareActor(
                  "assets/example.flr",
                  animation: 'activate',
                )),
            SizedBox(height: 20),
            Text("Order placed successfully!", style: TextStyle(fontSize: 23)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "You can expect delivery within the next 24 hours. For any assistance contact our customer care.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 80),
            Flex(
                direction: Axis.horizontal,
                children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: RaisedButton(
                    padding: EdgeInsets.all(16),
                    child: Text("Done"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {},
                    color: Color.fromRGBO(208, 208, 208, 1),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  child: RaisedButton(
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Track Order",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.amber,
                      onPressed: () {}),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
